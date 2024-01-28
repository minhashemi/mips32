# Q2 - 400109208 - Amin Hashemi - Matrix Operations (creation, transpose and print row by row)
# $s register content are saved and restored and the end to keep the code reusable.


.data
user_prompt: .asciiz "Enter the matrix size (n > 1): "
transposed_matrix_label: .asciiz "The transposed matrix"
end_of_line: .asciiz "\n"

.text
main:
  # Save callee-saved registers on the stack
  sub $sp, $sp, 32     # Adjust stack pointer to make room for 8 words (8 registers)
  sw $s0, 0($sp)
  sw $s1, 4($sp)
  sw $s2, 8($sp)
  sw $s3, 12($sp)
  
  # Prompt user for input
  li $v0, 4
  la $a0, user_prompt
  syscall

  # Read user input
  li $v0, 5
  syscall
  move $s3, $v0 # Store user input in $s3

  # Check if n is greater than 1
  bgt $s3, 1, matrix_operations
  j main # If n is not greater than 1, prompt again

matrix_operations:
  # Matrix creation
  move $a0, $s3
  jal allocate_matrix
  move $s2, $v0

  # Matrix transposition
  move $a0, $s2
  move $a1, $s3
  jal transpose_matrix

  # Print transposed matrix info
  li $v0, 4
  la $a0, transposed_matrix_label
  syscall
  li $v0, 4
  la $a0, end_of_line
  syscall
  move $a0, $s2
  move $a1, $s3
  jal print_matrix
  li $v0, 4
  la $a0, end_of_line
  syscall

  # Restore callee-saved registers from the stack
  lw $s0, 0($sp)
  lw $s1, 4($sp)
  lw $s2, 8($sp)
  lw $s3, 12($sp)
  addi $sp, $sp, 32    # Restore the stack pointer
  
  # Exit program
  li $v0, 10
  syscall

# Allocate memory for matrix
allocate_matrix:
  move $t0, $zero
  lui $t2, 0x1001
  add $t2, $t2, 100
  move $v0, $t2

  mult $a0, $a0
  mflo $a0

  # Loop to initialize matrix elements
  dataloop:
    beq $a0, $zero, enddata
    addi $t0, $t0, 1   # Start from 1 instead of 0
    sw $t0, 0($t2)
    addi $t2, $t2, 4
    addi $a0, $a0, -1
    j dataloop

  enddata: 
    jr $ra

# Transpose matrix
transpose_matrix:
  addi $t0, $a1, -1
  move $t1, $t0

  li $t8, -1
  # Loop for transposing the matrix
  rowloop:
    beq $t0, $t8, endrowloop
    addi $t1, $t0, -1
    columnloop:
      beq $t1, $t8, endcolumnloop

      # Calculate indices for accessing matrix elements
      mult $t0, $a1
      mflo $t2
      add $t2, $t2, $t1
      sll $t2, $t2, 2
      add $t2, $t2, $a0
      lw $t4, 0($t2)

      mult $t1, $a1
      mflo $t3
      add $t3, $t3, $t0
      sll $t3, $t3, 2
      add $t3, $t3, $a0
      lw $t5, 0($t3)

      # Swap matrix elements
      sw $t4, 0($t3)
      sw $t5, 0($t2)

      addi $t1, $t1, -1
      j columnloop

    endcolumnloop:
    addi $t0, $t0, -1
    j rowloop

  endrowloop:
    jr $ra

# Print matrix
print_matrix:
  move $s0, $a0
  move $s1, $a1

  mult $a1, $a1
  mflo $t0

  # Loop to print matrix row by row
  printloop:
    beq $t0, $zero, endprintloop

    div $t0, $s1
    mfhi $t1
    bne $t1, $zero, afterrowend

    li $v0, 4
    la $a0, end_of_line
    syscall

    afterrowend:
    lw $a0, 0($s0)
    li $v0, 1
    syscall

    addi $t0, $t0, -1

    # Align based on length
    li $v0, 11
    li $a0, 9  # ASCII code for \t
    syscall

    addi $s0, $s0, 4
    j printloop

  endprintloop:
    jr $ra
