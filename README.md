# Project Title
## 1. Project Overview
### 1.1 Project Name
Behavioural Modelling of a Charge-Pumped PLL

### 1.2 Description
This project focuses on the continuous-time behavioral modeling, analog testbench creation, and structured Verification Planning of a Charge-Pumped Phase-Locked Loop (CP-PLL).

### 1.3 Goals & Objectives
- Write modular Verilog-A behavioral code for a CP-PLL.
- Introduce physical circuit limitations into the models to verify loop stability under corner conditions.
- Deliver a complete GitHub repository containing a formal matrix tracking metrics like lock time, acquisition range, reference spur levels, phase margin, and peak overshoot.
- Create automated simulation scripts using open-source tools to sweep control voltages and input frequency steps, generating waveform analysis.

### 1.4 Key Features
- Phase Frequency Detector (PFD) for edge detection.
- Charge Pump (CP) with parameterized sink/source currents, finite output impedance, and realistic VDD clamping.
- Second-order passive RC loop filter, Voltage-Controlled Oscillator (VCO) with defined tuning sensitivity, and an Integer-N frequency divider.
- Impairment modeling including PFD dead-zone behavior, VCO phase jitter, and loop filter leakage current. 
- CP current mismatch ($I_{up} \neq I_{down}$) integrated directly into the initial Verilog-A model stages.

---

## 2. Requirements
### 2.1 Hardware Requirements
- Standard workstation capable of running open-source circuit simulation toolchains.

### 2.2 Software & Tools
- **OpenVAF:** Compact device modelling compiler.
- **ngspice:** Circuit simulator utilizing the XSPICE engine for mixed-signal logic.
- **Verilog-A:** For continuous-time behavioral modeling.

### 2.3 Constraints & Challenges
- OpenVAF does not support the event-driven Verilog-A constructs (such as `@(cross)`) required to build the edge-triggered digital logic of the PFD. 

---

## 3. Development Log

### 3.1 Research Links & Resources
| Date       | Link | Notes |
|------------|------|-------|
| 28/09/26 | [OpenVAF Docs](https://openvaf.github.io/docs/) | *Reference for compact device modeling capabilities* |
| 28/09/26 | [ngspice XSPICE](https://ngspice.sourceforge.io/xspice.html) | *Reference for digital logic block implementation* |

### 3.2 Key Decisions & Changes
- Due to compiler constraints, the PFD and CP implementations were split: the charge-pump is built purely in OpenVAF, while the PFD digital logic is handled externally.
- Advanced non-idealities planned for later stages, specifically the CP current mismatch and finite output impedance, were implemented early in the foundational Verilog-A charge pump model (`pfdcp.va`).

### 3.3 Issues & Solutions
- **Issue:** OpenVAF cannot compile the event-driven Verilog-A constructs required for the PFD's edge-triggered digital logic.
  - **Solution:** The charge pump was modeled in OpenVAF alone, while the PFD logic was successfully offloaded to ngspice's XSPICE engine utilizing simulated ADC/DAC bridges, D-flip-flops, and AND gates.

---

## 4. Development Process
### 4.1 Initial Steps
- Drafted the `pfdcp.vams` Verilog-A module, establishing continuous-time behavior with variables for threshold voltages (`vthresh`), nominal current (`I_nominal`), mismatch parameters, and output resistance (`R_out`).
- Constructed a mixed-signal ngspice testbench (`pfdcp.sp`) mapping reference and feedback clocks through XSPICE D-flip-flops to generate UP and DOWN states.
- Verified the alignment of reference and feedback clock test pulses for accurate phase comparison.
- Executed control scripts to generate waveform plots, successfully verifying both the mathematical step-response and realistic VDD-clamped outputs under a capacitive load.

Graph:
### Reference and Feedback Clock test inputs:

<img width="697" height="540" alt="image" src="https://github.com/user-attachments/assets/799e94b5-660c-47ca-a079-faf32bd95b4a" />
<img width="695" height="547" alt="image" src="https://github.com/user-attachments/assets/04746063-08b0-4f6d-9150-f8bf6fc6a55e" />

### Output of Phase-Frequency Detector with Charge Pump

<img width="682" height="532" alt="image" src="https://github.com/user-attachments/assets/fa55b320-ff34-4895-97ba-dc5f5b4c4868" />



