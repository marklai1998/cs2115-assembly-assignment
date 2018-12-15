# CS2115 Assembly Assignment

## Introduction
This repository is created for `City University HK` course `CS2115 - Computer Organization` assignment 4<br />
All credit goes to: Mark Lai

## Assignment Requirement
This project aim to build a program in assembly(MIPS) to perform a ID XNOR<br />
Store one of your group member’s ID (e.g. “Bob” with ID number 55332211) in the main memory<br />
Input a number from the screen (e.g. 54321111)<br />
and output bitwise XNOR (there XNOR means returning 0 when two digits are the same) of this number and A (e.g. 10100011, the 1st, 3nd and last two digits are the same)<br />
The input number can be less than 8-digit (e.g. 4321 then output 0001)<br />
If the input number is longer than 8-digit, print some error messages.<br />

## Getting Started
1. Clone the repository

2. Install [MARS (MIPS Assembler and Runtime Simulator)](http://courses.missouristate.edu/KenVollmar/mars/)

3. Open with MARS and start it

## Register Used

| Name | Usage                        |
| ---- | ---------------------------- |
| $t0  | Store the user input         |
| $t1  | Store the another ID         |
| $t2  | Number 10                    |
| $t3  | Counter of user input length |
| $t4  | temp                         |
| $t5  | temp                         |
| $t6  | The XNOR result              |
