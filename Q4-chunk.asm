.data
prompt:     .asciiz "Enter a number: "
result_msg: .asciiz "Bits 14-17 as decimal: "

.text
main:
    # Display prompt and get user input
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0  # Save user input in $t0

    # Extract bits 14-17
    li $t1, 0xF000   # Mask for bits 14-17 in hexadecimal
    and $t0, $t0, $t1            # Keep only bits 14-17
    
    srl $t0, $t0, 13            # Shift right to make the result in bits 0-3

    # Display the result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Display the result as decimal
    li $v0, 1
    move $a0, $t0
    syscall

    # Exit program
    li $v0, 10
    syscall
