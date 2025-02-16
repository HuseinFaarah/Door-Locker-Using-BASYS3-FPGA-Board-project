# FPGA-Based Door Locker System

## Overview

This project implements a **Door Locker System** using **VHDL** on an **FPGA** board. The system verifies a **password based on the student ID** and controls access to a door. The design incorporates **state machines, sequential circuits, and structural VHDL coding**.

## Objectives

- Design and implement a **Door Locker** using **VHDL**.
- Develop a **Finite State Machine (FSM)** for password verification.
- Implement **testbenches** for sequential circuits.
- Use **Structural VHDL** to integrate multiple components.

## Features

- **12-bit Password Input** (derived from a student ID in **hexadecimal** format).
- **Serial Password Verification** using a **State Machine**.
- **LED Indicators** for correct/incorrect password entry.
- **Reset Functionality** to restart the system.

## Project Components

- **Shift Register** – Stores and serially shifts the input password.
- **State Machine (SM.vhd)** – Checks the password bit by bit.
- **Register (Register.vhd)** – Stores user input.
- **Clock Divider (ClkDiv.vhd)** – Generates clock signals for operations.
- **Top-Level Design (Top.vhd)** – Integrates all modules.

## Hardware Requirements

- **FPGA Board** (e.g., Xilinx Basys 3 or similar)
- **12 Input Switches (SW0 - SW11)** for password entry
- **12 Output LEDs (LD0 - LD11)** for verification
- **Two Buttons**
  - **BTNR (Enable Input)** – Stores password in register.
  - **BTNL (Start Input)** – Initiates password verification.
- **LD14 (Stop Output LED)** – Indicates wrong password entry.
- **Reset Button** – Resets system to initial state.

## System Operation

1. **Enter Password**:  
   - Set the **12 switches (SW0 - SW11)** to match the **12-bit password**.
   - Push **BTNR** to store the input into the register.

2. **Start Verification**:  
   - Press **BTNL** to initiate the password checking process.
   - The system will compare the **stored password** against the correct **student ID password** **bit by bit**.
   - If correct, the corresponding **LEDs will light up sequentially**.

3. **Success / Failure Conditions**:  
   - If all **12 LEDs (LD0 - LD11) turn ON**, the door is unlocked.
   - If an incorrect bit is detected, the system **stays in the same state**, and **LD14 (Stop Output)** lights up.
   - The user must **reset the system** using the **Reset Button**.

## Implementation Steps

1. **Write a Testbench** for the shift register.
2. **Import Required VHDL Files** (`ClkDiv.vhd`, `Register.vhd`, `SM.vhd`).
3. **Create a Top-Level Design** (`Top.vhd`) and set it as the top module.
4. **Assign FPGA Pins** in the `.xdc` file.
5. **Generate Bitstream** and program the FPGA.
6. **Test the Design** on the FPGA board.


## License

This project is open-source under the **MIT License**.
