# MiniLang-C

A simple mini programming language implemented using Lex (Flex) and Yacc (Bison) in C. 
This project demonstrates how to define a basic syntax for variable declarations and assignments.

## Features

✅ Supports int, float, and string variable types 
✅ Allows variable declaration and assignment 
✅ Provides basic error handling for undeclared variables and type mismatches 
✅Simple and lightweight lexer and parser implementation

### Installation & Compilation

**Prerequisites**

Ensure you have:
-Flex (Lex implementation)
-Bison (Yacc implementation)
-GCC (C compiler)

**Steps to Compile**

1-Clone this repository:
```bash
git clone https://github.com/SOUFIANETAH/MiniLang-C.git
cd MiniLang-C
```
2-Compile using the following command:
```bash
flex minilang.l && bison -d minilang.y && gcc minilang.c minilangy.c -o minilang -lfl
```
3-Run the program:
```bash
./minilang
```
**Contributing**
Pull requests are welcome! If you find a bug or have suggestions, feel free to open an issue.

**Author**
TAHIRI SOUFIANE

