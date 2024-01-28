    .data
a:      .word 2, 5, 3, 7, 1     # Array 'a' with initialization.
b_value: .word 2                # Equivalent of 'int b = 2'
c_value: .space 4               # Space for 'c'
format: .asciiz "\n"          # Format string for printing.

    .text
    .globl main
main:
    # Initialize $s0 for 'i', $s1 to hold address of array 'a',
    # and $s2 to hold the constant value of 'b'.
    li $s0, 0                   # i = 0
    la $s1, a                   # Address of a
    lw $s2, b_value             # b = 2
    li $v0, 0                   # Initialize 'c' to 0 in $v0 to be used for comparison
    j loop_start                # Jump to beginning of loop

amin_function:
    # Arguments are passed in $a0 and $a1, result returned in $v0
    sll $t0, $a0, 1             # $t0 = 2 * m
    sub $v0, $t0, $a1           # $v0 = $t0 - n (which is 2m - n)
    jr $ra                      # Return to caller

loop_start:
    bge $s0, 5, end_loop        # for (i = 0; i < 5; i++) If i >= 5, exit loop

    # Access array element: a[i]
    sll $t1, $s0, 2             # $t1 = i * 4 (word size)
    add $t1, $t1, $s1           # $t1 = address of a[i]
    lw $t2, 0($t1)              # $t2 = a[i]

    # Conditional check: if (a[i] > b)
    ble $t2, $s2, set_zero      # if a[i] <= b, jump to set_zero

    # Run the amin function for c = amin(a[i], b);
    move $a0, $t2               # pass a[i] as first argument
    move $a1, $s2               # pass b as second argument
    jal amin_function          # Jump to amin function, result in $v0
    j store_value               # Jump to store value

set_zero:
    # Set c to 0
    li $v0, 0                   # equivalent of c = 0

store_value:
    # Store the result in 'c' and print it.
    sw $v0, c_value             # Store the result in 'c'
    # Printing code using syscall
    li $v0, 1                   # system call for print int
    lw $a0, c_value             # move value from c to $a0
    syscall                     # print c
    li $v0, 4                   # syscall for print string
    la $a0, format              # load address of newline format
    syscall                     # print newline

    # Increment 'i' and continue loop
    addi $s0, $s0, 1            # i = i + 1
    j loop_start                # Jump back to the beginning of the loop

end_loop:
    # End of the program.
    li $v0, 10                  # Exit syscall
    syscall