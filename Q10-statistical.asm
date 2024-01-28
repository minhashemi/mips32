# .data section
.data 
    msg_range:       .asciiz "enter n: "
    msg_number:      .asciiz "give me a number: "
    msg_average:     .asciiz "Average = "
    msg_variance:    .asciiz "Variance = "
    newline:         .asciiz "\n\r"
    array_ptr:       .word 0
    range_val:       .word 0

# .text section
.text
.globl main
    
main:
    # Prompt user for the range number
    la $a0, msg_range
    jal print_str

    # Read and store the range number
    jal read_int
    sw $v0, range_val # range_val contains n

    # Allocate memory from the heap
    lw $t0, range_val
    sll $a0, $t0, 2 # Multiply by 4 to have bytes
    li $v0, 9
    syscall 
    sw $v0, array_ptr
    lw $t0, range_val
    lw $t1, array_ptr
    li $t2, 0 # For sum X
    li $t3, 0 # For sum x^2
    li $t4, 0 # For the size of the array

# Fill the array loop
fill_array:
    beqz $t0, calculate
    la $a0, msg_number
    jal print_str
    jal read_int
    sw $v0, 0($t1)
    add $t2, $t2, $v0 # Sum x
    mul $t5, $v0, $v0 # x^2
    add $t3, $t3, $t5 # Sum x^2
    addi $t1, $t1, 4
    addi $t0, $t0, -1
    addi $t4, $t4, 1
    j fill_array

# Calculate average and variance
calculate:
    # Convert integer to float
    mtc1 $t2, $f1
    cvt.s.w $f1, $f1

    mtc1 $t3, $f2
    cvt.s.w $f2, $f2

    mtc1 $t4, $f3
    cvt.s.w $f3, $f3

    div.s $f4, $f1, $f3 # E(x) 
    div.s $f5, $f2, $f3 # E(x^2)

    # Print average
    la $a0, msg_average
    jal print_str

    sub.s $f0, $f0, $f0
    add.s $f12, $f4, $f0
    jal print_float

    # Print newline
    la $a0, newline
    jal print_str

    # Print variance
    la $a0, msg_variance
    jal print_str

    mul.s $f4, $f4, $f4
    sub.s $f12, $f5, $f4
    jal print_float

    j exit

# Exit program
exit:
    li $v0, 10
    syscall
    
# Print string subroutine
print_str:
    li $v0, 4
    syscall
    jr $ra

# Print float subroutine
print_float:
    li $v0, 2
    syscall
    jr $ra

# Read integer subroutine
read_int: 
    li $v0, 5
    syscall
    jr $ra
