# MIPS 32 Assembly Programs

This repository contains a collection of MIPS 32 assembly programs which I did during taking Principles of Computer Systems course from Prof. Laleh Arshadi at Sharif University of Technology, Fall 2023. MIPS (Microprocessor without Interlocked Pipeline Stages) is a popular RISC (Reduced Instruction Set Computing) architecture commonly used in embedded systems and academic settings.


## Programs

1. **Q1-Equivalence**
   - Description: Assuming that the variables `f`, `g`, and `h`, as well as the arrays `A` and `B`, are stored in the registers `$s0`, `$s1`, `$s2`, `$s6`, and `$s7`, and the address of the first element of arrays `A` and `B` is stored in `$s6` and `$s7` respectively. Write a MIPS program that is equivalent to
        ```MIPS 32
        g=g+h+B[4]
        g=g-A[B[4]]
        ```

2. **Q2-Leap Year**
   - Description: Write a program in MIPS that receives a number as input, representing a year, and checks whether it is a leap year or not. If it is a leap year, print 'YES'; otherwise, print 'NO'. The condition for a leap year is as follows:
   ```
   ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)
   ```
   - Test Case: 
   ```
    Input: 100
    Output: NO
    
    Input: 1400
    Output: NO
    
    Input: 1404
    Output: YES
   ```
3. **Q3-base 16**
   - Description: Write a program in MIPS that receives a number as input, and represents the input in base-16.
   - Test Case: 
   ```
    Input: 167
    Output: a7
    
    Input: 175
    Output: af
   ```

4. **Q4-chunk**
   - Description: Write a program in MIPS that receives a number as input, and outputs bits `14:17` (inclusive) as a binary number.
   - Test Case: 
   ```
    Input: 143360
    Output: 1
    
    Input: 11166000
    Output: 3
   ```

5. **Q5-java**
   - Description: Write a subroutine in MIPS that is equivalent to this Java code below. Note that it must get inputs in `$a0`, `$a1` and put the result in `$v0` register.
        ```java
        public class Main {
            public static int amin(int m, int n) {
                return 2 * m - n;
            }
        
            public static void main(String[] args) {
                int b = 2, c;
                int[] a = {2, 5, 3, 7, 1};
        
                for (int i = 0; i < 5; i++) {
                    if (a[i] > b)
                        c = amin(a[i], b);
                    else
                        c = 0;
                    System.out.println(c);
                }
            }
        }
        ```
 
 6. **Q6-parity**
   - Description: Write a program in MIPS that puts remainder of the register `$s0` (mod 2) in the same register. You are not allowed to use any other registers.
   Hint: You may use `sll`, `srl` to find parity of register content.

7. **Q7-sort**
   - Description: let 3 relatively small numbers (abs of numbers is less than $2^{29}$) be in registers `$s1`, `$s2`, `$s3`. Write a MIPS program that sorts these numbers without using conditional instructions (i.e. `bne`, `beq`) and puts them in `$t1`, `$t2`, `$t3` in increasing order. To do so, first write a _macro_ that finds maximum of two numbers and solve the problem using the macro.
  
8. **Q8-pie squared**
   - Description: write a MIPS program that gets `n` from the user and calculates square of $\pi$ using following series:
     $$\frac{\pi^2}{6} = \sum_{i=1}^n \frac{1}{i^2}$$

9. **Q9-nCr**
   - Description: Write a MIPS program that gets `n`, `r` from input and calculates ${n \choose r}$ using following recursion:
$${n\choose r} = {n-1 \choose r-1} + {n-1 \choose r}$$

10. **Q10-statistical**
   - Description: Write a MIPS program that first gets `n`, and then gets *n* numbers from input, then returns their _average_ and _variance_.
     Hint: to store numbers, use `syscall 9`

11. **Q11-encryption**
   - Description: The only secure way of encryption is One Time Pad (OTP). In this method, the main string and a random string with same length are `XOR` together to make the encrypted string.
write a MIPS program that gets seed (a string of length 4) and a string of maximum 20 byte length from input. Then make the random encryption key string, by repeatedly calling `syscall 42`. Let upperbound be 256 and seed be what user enters. At the end, print the encrypted string by `XOR`ing the input string and encryption key.


- [ ] Add more programs

## Getting Started

To run these MIPS assembly programs, you'll need the MARS (MIPS Assembler and Runtime Simulator) emulator. You can download it [here](http://courses.missouristate.edu/KenVollmar/MARS/).

## Running a Program

1. Clone the repository to your local machine:

    ```bash
    git clone https://github.com/your-username/mips-assembly-programs.git
    ```

2. Open MARS and load the program:

    - Click on "File" > "Open" and select the MIPS assembly file (e.g., `program_name.asm`).

3. Assemble the program:

    - Click on "Run" > "Assemble" to assemble the program.

4. Run the program:

    - Click on "Run" > "Go" to execute the program.

## Contributing

If you'd like to contribute to this repository by adding new programs or improving existing ones, please follow these steps:

1. Fork the repository.
2. Create a new branch:

    ```bash
    git checkout -b feature/new-program
    ```

3. Make your changes and commit them:

    ```bash
    git commit -m "Add new program: Program Name"
    ```

4. Push to the branch:

    ```bash
    git push origin feature/new-program
    ```

5. Open a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

Happy coding!
