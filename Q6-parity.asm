### IMPORTANT: We didn't use any other registers rather than $a0 for calculations. other registers are used to make the program work (I/O)


.data
.text
.globl main

main:
    # Prompt user for input
    li $v0, 4            # syscall for print_str
    la $a0, prompt       # load address of prompt string
    syscall

    # Read integer input
    li $v0, 5            # syscall for read_int
    syscall
    move $a0, $v0        # save the input in $a0

    # Check if the input is even or odd
    srl $a0, $a0, 1       # shift right by 1 (divide by 2)
    sll $a0, $a0, 1       # shift left by 1 (multiply by 2)

    # Compare original input with shifted input
    beq $v0, $a0, even    # if equal, the number is even
    li $a0, 1            # set $a0 to 1 (odd)
    j end_program

even:
    li $a0, 0            # set $a0 to 0 (even)

end_program:
    # Print the content of $a0
    li $v0, 1            # syscall for print_int
    move $a1, $a0        # load $a0 into $a1
    syscall

    # Exit program
    li $v0, 10           # syscall for exit
    syscall

    .data
prompt: .asciiz "Enter an integer: "
