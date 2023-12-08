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
