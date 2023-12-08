# Assuming f, g, h are located at registers $s0, $s1, $s2
# and the first index of arrays A, B are in $s6, $s7

# Load values from memory into registers
lw $t0, 16($s7)       # Load B[4] into $t0

# g = g + h + B[4]
lw $t1, 0($s1)       # Load value of g into $t1
lw $t2, 0($s2)       # Load value of h into $t2
add $t1, $t1, $t2    # g = g + h
lw $t2, 0($t0)       # Load value of B[4] into $t2
add $t1, $t1, $t2    # g = g + h + B[4]
sw $t1, 0($s1)       # Store the result back into g

# g = g - A[B[4]]
lw $t1, 0($s6)       # Load base address of array A into $t1
add $t1, $t1, $t2    # Add the offset B[4] to the base address of A
lw $t2, 0($t1)       # Load value of A[B[4]] into $t2
lw $t1, 0($s1)       # Load value of g into $t1
sub $t1, $t1, $t2    # g = g - A[B[4]]
sw $t1, 0($s1)       # Store the result back into g
