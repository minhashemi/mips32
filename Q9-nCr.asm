.data
promptN:    .asciiz "Enter value for n: "
promptR:    .asciiz "Enter value for r: "
promptAns:  .asciiz "C(n, r) = "
nl:         .asciiz "\n\r"
inputN:     .word 0
inputR:     .word 0
answer:     .word 0

.text
main:
    # Get input for N
    li      $v0, 4           # syscall code for print_str
    la      $a0, promptN     # load address of the prompt
    syscall

    li      $v0, 5           # syscall code for read_int
    syscall
    sw      $v0, inputN

    # Check for negative value
    bltz    $v0, main_exit

    # Get input for R
    li      $v0, 4           # syscall code for print_str
    la      $a0, promptR     # load address of the prompt
    syscall

    li      $v0, 5           # syscall code for read_int
    syscall
    sw      $v0, inputR

    # Call the recursive function
    lw      $a0, inputN
    lw      $a1, inputR
    jal     calculate_combination
    sw      $v0, answer

    # Print the result
    li      $v0, 4           # syscall code for print_str
    la      $a0, promptAns   # load address of the prompt
    syscall

    # Display the answer
    li      $v0, 1           # syscall code for print_int
    lw      $a0, answer
    syscall

    # Output newline
    li      $v0, 4           # syscall code for print_str
    la      $a0, nl           # load address of the newline
    syscall

main_exit:
    # Exit program
    li      $v0, 10          # syscall code for exit
    syscall

# Recursive function to calculate combinations
calculate_combination:
    addi    $sp, $sp, -20
    sw      $a0, 0($sp)      # save n
    sw      $a1, 4($sp)      # save r
    sw      $ra, 8($sp)      # save return address
    sw      $s0, 12($sp)     # save temporary register s0
    sw      $s1, 16($sp)     # save temporary register s1

    # Base case 1: C(n, 0) = 1
    li      $v0, 1
    beqz    $a1, recursive_done

    # Base case 2: C(n, n) = 1
    beq     $a1, $a0, recursive_done

    # Base case 3: C(n, 1) = n
    addi    $t0, $a0, -1
    li      $t1, 1
    add     $v0, $zero, $a0
    beq     $a1, $t0, recursive_done
    beq     $a1, $t1, recursive_done

    # Recursive calls
    addi    $a0, $a0, -1
    addi    $a1, $a1, -1
    jal     calculate_combination
    add     $s0, $zero, $v0
    lw      $a0, 0($sp)
    lw      $a1, 4($sp)
    addi    $a0, $a0, -1
    jal     calculate_combination
    add     $s1, $zero, $v0
    lw      $a0, 0($sp)
    lw      $a1, 4($sp)

    # Summing the results
    add     $v0, $s0, $s1
    lw      $s0, 12($sp)
    lw      $s1, 16($sp)

recursive_done:
    lw      $a0, 0($sp)
    lw      $a1, 4($sp)
    lw      $ra, 8($sp)
    lw      $s0, 12($sp)
    lw      $s1, 16($sp)
    addi    $sp, $sp, 20
    jr      $ra
