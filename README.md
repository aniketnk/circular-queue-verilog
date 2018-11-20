# Circular Queue – FIFO implementation in hardware

## Problem Description

Implement a circular queue (FIFO) buffer in hardware using Icarus Verilog. A FIFO(First in First Out) buffer is an elastic storage usually used between two subsystems. As the name indicates the memory that is first written into the FIFO is the first to be read or processed. A FIFO has two control signals i.e. write and read. When write is enabled data is written into the buffer and when read is enabled data is "removed" from the buffer to make room for more data.

## Implementation Details

A FIFO Buffer is a read/write memory array that automatically keep track of the order in which data enters the module and reads the data out in the same order. In hardware FIFO buffer is used for synchronization purposes. It is often implemented as a circular queue, and has two pointers:
1. Read Pointer/Read Address Register
2. Write Pointer/Write Address Register

Read and write addresses are initially both at the first memory location. When the read address and write address are equal then the FIFO queue is _Empty_. When the write address is _one_ value behind the read address of the FIFO buffer then the FIFO queue is _Full_.

### Modules used

#### Modules from lib.v file

1. **fa:** Used to increment read and write addresses.

2. **dfrl:** Used to store addresses in a register.

3. **and2:** Used to handle edge cases where queue is empty or full.

4. **xnor2:** Used to compare two numbers in isEqual module.

5. **and3:** Used in the isEqual module.

#### User defined modules

1. **reg_file:** Used to store data values. Register file includes eight 16-bit registers.

2. **ThreeBitRegister:** Used to store read and write pointers.

3. **isEqual:** Module outputs a Boolean stating whether the two inputs are equal or not.

4. **inc:** Increments input by value one.

## Running
To compile and build, run the following command:
```
iverilog lib.v cq.v reg_alu.v alu.v tb_cq.v -o out && vvp out
```
To view the output using gtkwave:
```
gtkwave tb_cq.vcd  
```
