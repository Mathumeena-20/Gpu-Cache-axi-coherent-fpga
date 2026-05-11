# 🚀 GPU Cache AXI Coherent FPGA Documentation

![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)
![Language](https://img.shields.io/badge/language-SystemVerilog-orange.svg)
![FPGA](https://img.shields.io/badge/target-CycloneV-green.svg)
![Protocol](https://img.shields.io/badge/cache-MOESI-red.svg)
![Bus](https://img.shields.io/badge/interface-AXI4-purple.svg)
![Simulation](https://img.shields.io/badge/simulation-ModelSim-blue)
![Synthesis](https://img.shields.io/badge/synthesis-Quartus-success)
![STA](https://img.shields.io/badge/STA-Timing_Analyzer-yellow)

# GPU Cache AXI Coherent FPGA Documentation

## 🚀 SystemVerilog | FPGA | Cache Coherency | AXI4

---

# 📑 Table of Contents

* Introduction
* Features
* Technologies
* Architecture
* MOESI Coherency
* MSHR & Non-Blocking Cache
* AXI4 Interface
* FPGA Flow
* Simulation
* Timing Analysis
* Results
* Project Structure
* Future Improvements
* Conclusion

---

# 📖 Introduction

The GPU Cache AXI Coherent FPGA project is a SystemVerilog-based coherent cache hierarchy implementing:

* Multi-core L1 cache system
* Directory-based cache coherency
* MOESI cache coherence protocol
* AXI4 memory interface
* MSHR-based non-blocking cache architecture
* FPGA synthesis and timing analysis

This project demonstrates a complete RTL-to-FPGA implementation flow including:

* RTL Design
* Functional Simulation (ModelSim)
* FPGA Synthesis (Quartus Prime)
* Place & Route
* Static Timing Analysis (STA)
* FPGA Bitstream Generation

The design targets scalable GPU-style memory hierarchy systems used in modern high-performance processors.

---

# ✨ Features

The coherent cache hierarchy supports:

## 🧠 Cache Features

* Multi-core L1 Cache Architecture
* Directory-based Coherency
* MOESI Cache Coherence Protocol
* Cache Hit/Miss Detection
* Shared Line Tracking
* Invalidation Handling
* Write Ownership Transfer

---

## 🚀 Performance Features

* Non-blocking Cache
* Hit-under-Miss
* Miss-under-Miss
* Multiple Outstanding Misses
* MSHR (Miss Status Holding Register)

---

## 🔄 AXI4 Features

* AXI Read Address Channel
* AXI Read Data Channel
* Burst Transactions
* ARVALID / ARREADY
* ARLEN / ARSIZE
* RVALID / RLAST

---

## ⚡ FPGA Features

* Quartus FPGA Synthesis
* Timing Closure
* Static Timing Analysis
* Resource Utilization Analysis
* Cyclone V FPGA Support

---

# 🛠️ Technologies

Technologies used in this project:

| Technology         | Usage                 |
| ------------------ | --------------------- |
| SystemVerilog      | RTL Design            |
| ModelSim           | Functional Simulation |
| Quartus Prime Lite | FPGA Synthesis        |
| Timing Analyzer    | STA                   |
| Cyclone V FPGA     | Target Device         |
| GitHub             | Version Control       |

---

# 🧠 Architecture

## 🏗️ System Overview

```text
                    +----------------------------------+
                    |      GPU CACHE SYSTEM TOP        |
                    +----------------+-----------------+
                                     |
    ----------------------------------------------------------------
    |                 |                 |                 |
    v                 v                 v                 v

+-----------+   +-----------+   +-----------+   +-----------+
|  L1 CACHE |   |  L1 CACHE |   |  L1 CACHE |   |  L1 CACHE |
|   CORE0   |   |   CORE1   |   |   CORE2   |   |   CORE3   |
+-----------+   +-----------+   +-----------+   +-----------+

        \             |              |              /
         \            |              |             /
          -----------------------------------------
                              |
                              v

                 +-----------------------------+
                 |   DIRECTORY CONTROLLER      |
                 |    (MOESI COHERENCY)        |
                 +--------------+--------------+
                                |
                                v

                 +-----------------------------+
                 |            MSHR             |
                 |  Outstanding Miss Tracking  |
                 +--------------+--------------+
                                |
                                v

                 +-----------------------------+
                 |         AXI MASTER          |
                 +--------------+--------------+
                                |
                                v

                 +-----------------------------+
                 |         AXI MEMORY          |
                 +-----------------------------+
```

---

## Block Diagram

...

...

<img width="1297" height="867" alt="image" src="https://github.com/user-attachments/assets/d005795f-cc8d-4071-bbb3-61f14dda86ee" />

...

...

# 🔄 MOESI Coherency Protocol

The cache hierarchy implements:

| State | Meaning   |
| ----- | --------- |
| M     | Modified  |
| O     | Owned     |
| E     | Exclusive |
| S     | Shared    |
| I     | Invalid   |

---

## 🧠 Coherency Operations

### Read Miss

* Directory lookup
* Shared state update
* Data refill

### Write Miss

* Invalidate sharers
* Ownership transfer
* Modified state assignment

### Invalidation

* Broadcast invalidation vector
* Sharer removal

---

# 🚀 MSHR & Non-Blocking Cache

The design supports:

## Multiple Outstanding Misses

Example:

```systemverilog
Core0 -> 0x1000
Core1 -> 0x2000
Core2 -> 0x3000
Core3 -> 0x4000
```

tracked simultaneously using MSHR entries.

---

## Non-blocking Features

### ✅ Hit-under-Miss

Cache can serve hits while miss refill is pending.

### ✅ Miss-under-Miss

Multiple misses processed concurrently.

---

# 🔄 AXI4 Interface

The memory subsystem uses AXI4-style transactions.

---

## AXI Signals

### Read Address Channel

| Signal  | Function           |
| ------- | ------------------ |
| ARVALID | Read request valid |
| ARREADY | Memory ready       |
| ARADDR  | Read address       |
| ARLEN   | Burst length       |
| ARSIZE  | Burst size         |

---

## Read Data Channel

| Signal | Function            |
| ------ | ------------------- |
| RVALID | Read response valid |
| RDATA  | Read data           |
| RLAST  | Burst complete      |

---

## 🌊 Waveforms

# Cache Coherency Waveform

...

...

<img width="1877" height="1002" alt="moesi_coherent_ GPU_Cache_Hierarchy_Waveform" src="https://github.com/user-attachments/assets/780f670b-c921-4c77-8229-812708c6eddf" />

...

...

# AXI Waveform

...

...

<img width="1890" height="940" alt="axi_ar_channel_timing" src="https://github.com/user-attachments/assets/36596e6c-43c8-4313-9f6b-80f7264c385d" />

...

...

 ### 📊 FPGA Synthesis Reports

 # Chip Planner

 ...

 ...

 <img width="1492" height="1000" alt="chip_planner" src="https://github.com/user-attachments/assets/945437b7-8acd-4c36-a564-50ee56fb0030" />

 ...

 ...

 ## Timing Analyzer

 # SetUp Time

 ...

 ...

 <img width="1587" height="681" alt="setup_time" src="https://github.com/user-attachments/assets/182b0d6d-99de-404a-a732-d1f3e083e364" />

 ...

 ...

 # Hold Time

 ...

 ...

 <img width="1591" height="662" alt="hold_time" src="https://github.com/user-attachments/assets/52c4d6ca-8037-48b4-a25a-23e8b11786c3" />

 ...

 ...

# ⚙️ FPGA Flow

## Complete FPGA Implementation Flow

### 1️⃣ RTL Design

SystemVerilog RTL modules.

### 2️⃣ Simulation

ModelSim functional verification.

### 3️⃣ Synthesis

Quartus Analysis & Synthesis.

### 4️⃣ Place & Route

FPGA resource mapping.

### 5️⃣ Static Timing Analysis

Setup/Hold timing verification.

### 6️⃣ Bitstream Generation

`.sof` FPGA programming file.

---

# 🚀 Quickstart

## 1️⃣ Clone Repository

```bash
git clone <your-repository-link>
cd gpu-cache-axi-coherent-fpga
```

---

## 2️⃣ Run ModelSim Simulation

```tcl
vlib work

vlog RTL/**/*.sv
vlog TESTBENCH/*.sv

vsim work.tb_gpu_cache_system

add wave -r /*

run -all
```

---

## 3️⃣ FPGA Synthesis (Quartus)

### Add Files

Add all `.sv` files into Quartus project.

### Set Top Module

```text
gpu_cache_fpga_top
```

### Add SDC File

```tcl
create_clock -name clk -period 10.0 [get_ports clk]
```

### Compile Design

```text
Processing
→ Start Compilation
```

---

# 📊 Simulation Results

✔ Functional Simulation Successful

✔ Cache Hit/Miss Verified

✔ MOESI State Transition Verified

✔ AXI Transactions Verified

✔ Directory Invalidation Verified

✔ Multiple Outstanding Misses Verified

✔ Non-blocking Cache Operation Verified

---

# 📈 FPGA Results

✔ Quartus Compilation Successful

✔ Timing Analysis Successful

✔ FPGA Bitstream Generated

✔ Static Timing Analysis Completed

✔ Setup/Hold Timing Verified

✔ Cyclone V FPGA Compatible

---

# 📷 Verification Artifacts

The project includes:

* ModelSim waveforms
* AXI transaction waveforms
* RTL Viewer screenshots
* Technology Map Viewer
* Chip Planner screenshots
* Timing Analyzer reports

---

# 📁 Project Structure

```text
gpu-cache-axi-coherent-fpga/
│
├── RTL/
│   ├── axi/
│   ├── coherency/
│   ├── l1_cache/
│   └── top/
│
├── TESTBENCH/
│
├── simulations/
│
├── synthesis/
│
├── docs/
│   ├── architecture.png
│   ├── axi_waveform.png
│   ├── timing_report.png
│   └── chip_planner.png
│
├── constraints.sdc
│
├── README.md
│
└── LICENSE
```

---

# 🔥 Future Improvements

Future enhancements planned:

* L2 Shared Cache
* Victim Cache
* AXI Write Channel
* DDR Controller Integration
* Full UVM Verification
* SystemVerilog Assertions (SVA)
* MESIF Protocol Support
* NoC-based Coherency

---

# ⭐ Conclusion

This project demonstrates a complete coherent GPU cache hierarchy implementation with:

* MOESI cache coherency
* AXI4 interface
* MSHR-based non-blocking cache
* FPGA synthesis and timing analysis
* Full RTL-to-FPGA flow
