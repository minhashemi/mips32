.data
prompt: .asciiz "Enter the year: "
yes:    .asciiz "YES"
no:     .asciiz "NO"

.text
.globl main

main:
    # Print prompt to the user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read user input (the year)
    li $v0, 5
    syscall

    # Move the read year to $t0
    move $t0, $v0

    # Check if the year is evenly divisible by 4
    li $t1, 4
    div $t0, $t1
    mfhi $t2
    bnez $t2, not_leap # If remainder is not zero, jump to not_leap

    # Check if the year is not evenly divisible by 100
    li $t1, 100
    div $t0, $t1
    mfhi $t2
    beqz $t2, check_400 # If remainder is zero, need to check for divisibility by 400

    # It's a leap year case 1
    leap_year:
        li $v0, 4
        la $a0, yes
        syscall
        j end

    # Need to further check divisibility by 400 (for case year%100 == 0)
    check_400:
        li $t1, 400
        div $t0, $t1
        mfhi $t2
        beqz $t2, leap_year # If remainder is zero, it's a leap year

    # Not a leap year
    not_leap:
        li $v0, 4
        la $a0, no
        syscall

    # End of program
    end:
        li $v0, 10
        syscall