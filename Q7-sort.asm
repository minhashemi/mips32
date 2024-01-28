.data
space: .asciiz " "  # String representing a space

.text

# Macro to compute the absolute value of a number
# Usage: ABSOLUTE($num, $absnum)
.macro ABSOLUTE($num, $absnum)
    sra $t2, $num, 31      # Get the sign of $num
    xor $num, $num, $t2    # If negative, negate $num
    sub $absnum, $num, $t2  # If negative, negate $absnum
.end_macro

# Macro to find the maximum of two numbers
# Usage: MAX($num1, $num2, $max)
.macro MAX($num1, $num2, $max)
    add $t0, $num1, $num2   # $t0 = $num1 + $num2
    sub $t1, $num1, $num2   # $t1 = $num1 - $num2
    ABSOLUTE($t0, $t0)      # Compute the absolute value of $t0
    ABSOLUTE($t1, $t1)      # Compute the absolute value of $t1
    add $max, $t0, $t1      # $max = $t0 + $t1
    srl $max, $max, 1       # $max = $max >> 1 (divide by 2)
.end_macro

# Initialization: Store three small numbers in $s1, $s2, and $s3
addi $s1, $zero, 12
addi $s2, $zero, -23
addi $s3, $zero, 55

# Sorting Logic:
MAX($s1, $s2, $t4)          # Find max of $s1 and $s2, store in $t4
MAX($s3, $t4, $t3)          # Find max of $s3 and $t4, store in $t3
MAX($s2, $s3, $t5)          # Find max of $s2 and $s3, store in $t5
MAX($s1, $s3, $t6)          # Find max of $s1 and $s3, store in $t6

add $t4, $t4, $t5           # $t4 = $t4 + $t5 (max*2 + mid)
add $t4, $t4, $t6           # $t4 = $t4 + $t6 (max*2 + mid)

sll $t7, $t3, 1             # $t7 = $t3 << 1 (max * 2)

sub $t2, $t4, $t7           # $t2 = $t4 - $t7 (arranged in ascending order)

add $t5, $s1, $s2
add $t5, $t5, $s3           # $t5 = $s1 + $s2 + $s3 (sum s1, s2, s3)

sub $t5, $t5, $t3           # $t5 = $t5 - $t3 (subtract max)
sub $t1, $t5, $t2           # $t1 = $t5 - $t2 (min)

# Print the arranged numbers from small to large
li $v0, 1                   # Print an integer
move $a0, $t1               # Move the smallest number to $a0
syscall

li $v0, 4                   # Print a space
la $a0, space
syscall

li $v0, 1
move $a0, $t2               # Move the middle number to $a0
syscall

li $v0, 4                   # Print a space
la $a0, space
syscall

li $v0, 1
move $a0, $t3               # Move the largest number to $a0
syscall

# Halt the program
li $v0, 10
syscall
