# Data Section
.data
    input:  .space 256 #buffer to store input and reverse in-place
    output: .space 256 #buffer to make the reverse string
    prompt: .asciiz "Enter a string (up to 256 characters): "
    result_prompt: .asciiz "Modified string: "

# Text Section
.text
main:
    # Prompt user for input
    li   $v0, 4          # Syscall code for printing a string
    la   $a0, prompt     # Load the address of `prompt`
    syscall

    # Ask the user for input
    li   $v0, 8           # Syscall code for reading a string
    la   $a0, input       # Store the input in 'input'
    li   $a1, 256         # Limit to 256 chars/bytes!
    syscall

    # Convert lowercase to uppercase using recursive subroutine
    la   $a0, input        # Load the address of the buffer
    jal  convertToLowerRecursive

    # Output the modified string for verification
    li   $v0, 4            # Syscall code for printing a string
    la   $a0, input
    syscall

    # Call strlen function to get the length of the modified string
    jal  strlen            # Saves the return address to $ra

    # Copy parameters for reverse function
    add  $t1, $zero, $v0   # Copy length to $t1
    add  $t2, $zero, $a0   # Save input string to $t2
    add  $a0, $zero, $v0   # Copy length to $a0 (syscall may modify it)

    # Reverse the string
reverse:
    li   $t0, 0            # Set counter to zero
    li   $t3, 0            # Initialize another counter

    # Loop to reverse the string
reverse_loop:
    add  $t3, $t2, $t0     # $t2 is the base address for 'input', add loop index
    lb   $t4, 0($t3)       # Load a byte at a time according to counter
    beqz $t4, exit         # Check for null-byte, exit if found
    sb   $t4, output($t1)  # Overwrite byte address in memory
    subi $t1, $t1, 1       # Decrement overall string length by 1 (j--)
    addi $t0, $t0, 1       # Increment counter (i++)
    j    reverse_loop      # Loop until the condition is met

exit:
    li   $v0, 4            # Syscall code for printing a string
    la   $a0, output
    syscall

    li   $v0, 10           # Syscall code for exit
    syscall

# strlen function
strlen:
    li   $t0, 0            # Initialize loop counter to zero
    li   $t2, 0            # Initialize length to zero

    # Loop to find the null byte
strlen_loop:
    add  $t2, $a0, $t0     # Calculate the address of current char
    lb   $t1, 0($t2)       # Load the current char
    beqz $t1, strlen_exit  # If null byte is found, exit the loop
    addiu $t0, $t0, 1      # Increment loop counter
    j    strlen_loop       # Continue the loop

strlen_exit:
    subi $t0, $t0, 1       # Subtract 1 to get the length
    add  $v0, $zero, $t0   # Set the return value to the length
    add  $t0, $zero, $zero # Reset counter
    jr   $ra               # Return

# Recursive subroutine to convert lowercase to uppercase
convertToLowerRecursive:
    lb   $t1, 0($a0)       # Load the current char

    # Check if it's end of string
    beq  $t1, $zero, convert_done_recursive

    # Check if the char is lowercase 
    blt  $t1, 'a', not_lowercase_recursive
    bgt  $t1, 'z', not_lowercase_recursive

    # Convert lowercase to uppercase
    sub  $t1, $t1, 32
    sb   $t1, 0($a0)

not_lowercase_recursive:
    addi $a0, $a0, 1       # Move to the next char 
    j    convertToLowerRecursive

convert_done_recursive:
    jr   $ra               # Return
