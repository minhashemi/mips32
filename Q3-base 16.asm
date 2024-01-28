.data
    prompt:     .asciiz "Enter a non-negative int: "
    result:     .asciiz "Hexadecimal: "
    newline:    .asciiz "\n"
    buffer:     .space  12    # Adjust the size as needed

.text
    main:
        # Print prompt
        li $v0, 4
        la $a0, prompt
        syscall

        # Read integer input
        li $v0, 5
        syscall
        move $t0, $v0  # Save user input in $t0

        # Convert integer to hexadecimal
        li $v0, 34       # Code for printing hexadecimal integer
        move $a0, $t0    # Load user input into $a0
        syscall

        # Print newline
        li $v0, 4
        la $a0, newline
        syscall

        # Exit program
        li $v0, 10
        syscall
