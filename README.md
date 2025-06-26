# 🧠 32-bit Single-Cycle RISC-V Processor

RISC-V (pronounced "risk-five") is an open-source Instruction Set Architecture (ISA) gaining wide popularity for its flexibility, scalability, and open ecosystem. Unlike traditional ISAs like x86 or ARM, RISC-V is free and modifiable without licensing restrictions—making it a powerful choice for academic research and commercial products.

This project presents a **32-bit Single-Cycle RISC-V processor** implemented in Verilog HDL.

---

## 🚀 Why RISC-V?

- ✅ **Open-source** and royalty-free
- ✅ **Customizable** for embedded or high-performance designs
- ✅ **Modular** architecture supporting extensibility
- ✅ Rapidly growing support in both industry and academia

---

## 📐 Architecture Overview

The processor is based on the **RV32I** instruction set, designed with a **single-cycle datapath**. Key features:

- 32 general-purpose registers (`x0` is always zero)
- Support for signed/unsigned arithmetic and logic operations
- Modular, RTL-level design in Verilog
- Tested using MIPS-compatible assembly

---

## 🧩 Instruction Formats

RISC-V defines six main instruction formats:

| Format | Description                                   |
|--------|-----------------------------------------------|
| R-Type | Register-to-register ALU operations           |
| I-Type | Immediate ALU operations and Load instructions|
| S-Type | Store instructions                            |
| B-Type | Branch instructions                           |
| U-Type | Upper immediate instructions                  |
| J-Type | Jump instructions                             |

---

## 🛠️ R-Type Instructions

Used for ALU operations (add, sub, and, or, xor, etc.)


---

## 🧮 I-Type Instructions

Used for immediate arithmetic, loads, and environment calls.


---

## 🔁 J-Type and B-Type

- **J-Type** for jump and link (`JAL`)
- **B-Type** for conditional branches

Each uses signed immediates to calculate the target address relative to `PC`.

---

## 📂 Project Architecture
![image](https://github.com/user-attachments/assets/7fd2f79b-e7de-40b2-8aa3-8405db207adb)


---
## 📷 Diagram
### Tast 1:
![image](https://github.com/user-attachments/assets/d2cc4b87-4a80-4aba-a2aa-7897fd3de294)

### Tast 2:
![image](https://github.com/user-attachments/assets/7af5af11-8e78-431f-ba82-5dbe9fbc1749)



### Tast 3:
This Test is created to: Verify Conditional & Unconditional Branch Instructions: bltz, bgez, blez, bgtz, beq, bne, j, jal, jr, jalr 
2-Verify the Arithmetic-Logical Instructions: add, addu, sub, subu, and, or, xor, nor, slt, sltu 
![image](https://github.com/user-attachments/assets/5dd74176-5ac8-4597-b987-3b44fce774ef)

## 🧪 Tools Used

- **Verilog HDL**
- **QuestaSim / ModelSim** for simulation
- **Vivado** for synthesis and testing
- **GTKWave** for waveform analysis

---

## 🧠 Key Modules

- ✅ ALU
- ✅ Register File
- ✅ Program Counter
- ✅ Instruction & Data Memory
- ✅ FSM Control Unit
- ✅ Immediate Generator
- ✅ Branch & Jump Logic

---

## 📷 Elaborate
![image](https://github.com/user-attachments/assets/7448308c-bf15-4d2a-9546-deb6db666258)

## 📷 synthesis
![image](https://github.com/user-attachments/assets/e9eb580a-9ed7-46ee-be80-e0c1af984fb1)



