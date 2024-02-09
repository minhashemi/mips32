
.data
prompt:  .asciiz "Enter n: " # Prompt to ask user for 'n'

.text
.globl main
main:
    # Print prompt to user
    li    $v0, 4           # Load syscall code for print string
    la    $a0, prompt      # Load address of the prompt
    syscall                # Make syscall to print prompt

    # Read integer from user
    li    $v0, 5           # Load syscall code for read integer
    syscall                # Make syscall to read integer from user

    # Initialize variables
    move  $t0, $v0         # Move input number to $t0 for comparison
    li    $t1, 1           # Set loop index i
    li    $t7, 0           # Set register $t7 to 0 to be used as floating point 0
    
    # Floating point initialization
    mtc1  $t7, $f0         # Move 0 to floating point register $f0, sum initialized at 0
    cvt.s.w $f0, $f0       # Convert integer 0 to float
    mtc1  $t1, $f4         # Move 1 to floating point register $f4, our constant 1.0
    cvt.s.w $f4, $f4       # Convert integer 1 to float
    
Calculate_Sum:
    mul   $t3, $t1, $t1    # Multiply i by itself
    mtc1  $t3, $f6         # Move the result to floating point register
    cvt.s.w $f6, $f6       # Convert result to float
    
    div.s $f2, $f4, $f6    # Divide 1.0 by (i*i) as a float
    add.s $f0, $f0, $f2    # Add the fraction to the sum
    addi  $t1, $t1, 1      # Increment loop index i
    ble   $t1, $t0, Calculate_Sum  # If i <= n continue loop
    
End_Loop:
    # Multiply the result by 6 and prepare for printing
    mtc1  $t7, $f12        # Move 0 to floating point register $f12
    cvt.s.w $f12, $f12     # Convert register $f12 to float
    li    $s6, 6           # Load 6 into register $s6
    mtc1  $s6, $f10        # Move 6 to floating point register $f10
    cvt.s.w $f10, $f10     # Convert integer 6 to float
    mul.s $f0, $f0, $f10   # Multiply the sum by 6
    
    # Print floating point result
    add.s $f12, $f12, $f0  # Add sum to $f12 for printing
    li    $v0, 2           # Load syscall code for print float
    syscall                # Make syscall to print float
    
    # Program exit
    li    $v0, 10          # Load syscall code for exit
    syscall                # Make syscall to exit
