.data
    seed:           .space 5
    inputString:    .space 21
    encryptedString:    .space 21
    promptSeed:     .asciiz "Enter the encryption key (4 characters): \n"
    promptString:   .asciiz "Enter the message to encrypt (max 20 bytes): \n"
    promptEncrypt:  .asciiz "\nEncrypted Message: \n"

.text
main:
    # Prompt user to enter the encryption key
    li $v0, 4       # syscall 4 (print_str)
    la $a0, promptSeed
    syscall

    # Receive encryption key from user input
    li $v0, 8       # syscall 8 (read_str)
    la $a0, seed
    li $a1, 5       # maximum byte length for the key
    syscall

    # Prompt user to enter the message
    li $v0, 4       # syscall 4 (print_str)
    la $a0, promptString
    syscall

    # Receive message input from user
    li $v0, 8       # syscall 8 (read_str)
    la $a0, inputString
    li $a1, 21      # maximum byte length for the message
    syscall

    # Initialize random key
    li $t0, 0       # initialize random key index to 0

    jal strlen 
randomLoop:
    # Check if random key is complete
    beq $t0, $t1, xorStrings

    # Call syscall 42 to generate random number and set key
    li $v0, 42      # syscall 42 (set random seed)
    la $a0, seed    # pass key as argument
    li $a1, 256     # upperbound value
    syscall

    # Store the generated random number in random key
    lb $t3, inputString($t0)    # load byte from inputString
    xor $t3, $t3, $v0           # xor with random number
    sb $t3, encryptedString($t0)    # store the result in encryptedString

    addi $t0, $t0, 1    # increment index
    j randomLoop

xorStrings:
    # Print the encrypted message
    li $v0, 4       # syscall 4 (print_str)
    la $a0, promptEncrypt
    syscall
    
    li $v0, 4       # syscall 4 (print_str)
    la $a0, encryptedString
    syscall

    # Exit program
    li $v0, 10      # syscall 10 (exit)
    syscall
    
    
strlen:
    li $t1, 0    # initialize the count to zero
    la $a0, inputString
loop:
    lb $t2, 0($a0)    # load the next character into t1
    beqz $t2, jump_ra    # check for the null character
    addi $a0, $a0, 1    # increment the string pointer
    addi $t1, $t1, 1    # increment the count
    j loop    # return to the top of the loop    

jump_ra:
    jr $ra
