# Writing Some Assembly Fragments

Before we start writing functions in assembly language, we will start writing some simple assembly "fragments".  

##  Overview
0. You need multiple incremental commits and descriptive commit messages.
    - At minimum, you should make one commit for each fragment, but you should add more for full points.
    - Good example: git commit -m "Converted IMUL_POSITIVE from byte value to quad value."
    - Bad example: git commit -m "Updated and.s" 

1. The assembly source code files containing the functionality of each fragment.
    - `and.s, or.s, shl.s`
    - **You will need to create these files and implement their functionality**.

2. The testing suite (provided) to evaluate the correctness of each fragment 
    - Assembly source code files: `andtest.s, ortest.s, shltest.s`
    - Bash test script files: `andtest.sh, ortest.sh, shltest.sh`

3. **Create** a `Makefile` with recipes that assemble source code into object files and then link them into an executable.
    - Each test assumes these recipes are present; if any are missing, you’ll see errors. 
    - Check the test code particularly where it calls `make` to see which recipes you need for each fragment.

4. **Create** files for answers to GDB-related questions.
    - `and.txt, or.txt, shl.txt`

To implement each fragment, your code should contain a symbolic label identifying the beginning of its instructions. Usually this would be the `_start` label, but for this assignment, the names that you should use for the symbolic labels in each fragment are provided later in this README. In addition, given we don't know how to write complete functions yet, our fragments finish by trapping back to the debugger. See the lecture notes here for more info on trapping:

https://cs-210-infrastructure.github.io/UndertheCovers/lecturenotes/assembly/L08.html#interrupt-3-int3-trap-to-debugger

With this in mind, our code is "run" and tested using the `gdb` debugger. For example, each provided test script starts `gdb` with your executable file and then runs `gdb` commands to exercise your fragment. You should use `gdb` by hand to explore the test code and your fragments.

**Lastly, don't blindly use the test scripts! They are there for you to explore and learn from.**


## Reference Information

- Assembly and GDB Reference Sheet
    - Containins a summary of all the Intel assembly instructions, addressing mode syntax, and gdb commands you need.:
    - https://cs-210-infrastructure.github.io/UndertheCovers/textbook/images/INTELAssemblyAndGDBReferenceSheet.pdf

- Intel Instruction Manuals
    - For further information about all of the Intel instructions and their functionality.
    - Chapters 3, 4, and 5 of Volume 2A make up the instruction set reference documentation.
    - https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
    
- UCSLS Lecture Notes: Lecture #9
    - A summary and further guidance of address mode syntax for operands that is beyond what is on the reference sheet.
    - https://cs-210-infrastructure.github.io/UndertheCovers/lecturenotes/assembly/L09.html#addressing-modes-for-sources-and-destinations


## The Fragments To Write

There are three fragments to be developed: `AND_FRAG`, `OR_FRAG`, and `SHL_FRAG`.  All of these are described below.

### Important Notes
- **Variables x and y in the fragment descriptions are only used to aid in understanding the problem. Instead, use the corresponding registers - the testing code will load values into these registers for you.**

- **Do not use the following descriptions as a comment in your final submission. Points will be deducted if you do.**

- **When assembling and linking your files in order to produce an executable, be sure to link together both your source code and the test source code. There's not much we can do with a fragment alone!**

### File: `and.s` Fragment Symbol Name: `AND_FRAG`

#### Description
```
	# AND_FRAG Fragment
	# INPUTS: rax -> x
	#         rbx -> &y (the address of where in memory y is)
	# OUTPUTS: x = x bitwise and y : update rax with bitwise AND of rax and the 
	#                                8 byte quantity at the location of &y
	#          In addition, rbx should be updated to equal &y + 8
```

Study the test code, `andtest.s`, to figure out exactly what is expected of your AND_FRAG routine.  The `andtest.sh` script will be used to test your solution, but you are encouraged to write your own more complex test program to ensure that you understand what is going on. 

### AND Fragment - GDB Question
**What is the address, in hexadecimal format, that the `data_end` symbol represents in the andtest binary?**

Please type your answer into a new `and.txt` file, adding the 0x prefix and ensuring no extra spaces or newlines are in the file. For example, if you believe the answer was 0x12345678, you can do this with the following command: `echo -n 0x12345678 > and.txt`. If you'd like to change your answer, you can use the same command - it will overwrite the contents of the `and.txt` file.

---

### File: `or.s` Fragment Symbol Name: `OR_FRAG`

Similar to above, but with the 'or' operation.  

#### Description

```
        # INPUTS: rax -> x
        #         rbx -> &y (the address of where in memory y is)
        # OUTPUTS: x = x bitwise or y : update rax with bitwise OR of the 
        #                               8 byte quantity at the location of &y
        #          In addition, rbx should be updated to equal &y + 8
```

Study the test code, ``ortest.s``, to figure out exactly what is expected of your OR_FRAG routine.  The `ortest.sh` script will be used to test your solution, but you are encouraged to write your own more complex test program to ensure that you understand what is going on. 

### OR Fragment - GDB Question
**What is the value, in hexadecimal, of the rax register after one pass of the OR_FRAG in the ortest binary?**

Please type your answer into a new `or.txt` file, adding the 0x prefix and ensuring no extra spaces or newlines are in the file.

---

### File: `shl.s`  Fragement Symbol Name: `SHL_FRAG`

Now that we have gotten the hang of the mechanics, let's write a fragment that is a little more involved and operates on memory as well as registers.

#### Description
```
        # INPUTS: rax -> x
        #         rbx -> &y address of where in memory y is
        # OUTPUTS: x = x << y : update rax by shifting left y
        #                      quantity at the location of &y
        #          if y is positive then add y into an 8 byte value
        #          stored at a location marked by a symbol
        #          named SUM_POSTIVE
        #          else add y into an 8 byte value stored at a 
        #          location marked by a symbol named SUM_NEGATIVE
        #          final rbx should be updated to equal &y + 8
        #
        # This file must provide the symbols SUM_POSTIVE 
        # and SUM_NEGATIVE and associated memory
```        

Study the test code, `shltest.s`, to figure out exactly what is expected of your SHL_FRAG routine.  The `shltest.sh` script will be used to test your solution, but you are encouraged to write your own more complex test program to ensure that you understand what is going on. 

### SHL Fragment - GDB Question
**When examining memory in GDB, what is the one hexadecimal 8-byte/giant value stored at the location in memory marked by the symbol _start?**

Please type your answer into a new `shl.txt` file, adding the 0x prefix and ensuring no extra spaces or newlines are in the file.

---

### You've made it to the end of the README! 

### REMINDER: You need multiple incremental commits and descriptive commit messages.
- At minimum, you should make one commit for each fragment, but you should add more for full points.
- Good example: git commit -m "Converted IMUL_POSITIVE from byte value to quad value."
- Bad example: git commit -m "Updated and.s" 
### Submit your work to Gradescope:
- You should submit the following files: `and.s, or.s, shl.s, and.txt, or.txt, shl.txt, Makefile`  :)


#### Goodluck, here's a random cat image:
![Random Cat Image](https://http.cat/images/418.jpg)

Source: [link](https://http.cat/status/418)
