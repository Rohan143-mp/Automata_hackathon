# IoT Connection Guide: Steps 1 & 2

---

## Step 1: Voltage Divider (5V → 3.3V)

The Uno TX is 5V, ESP8266 RX is 3.3V. A voltage divider steps it down safely.

```mermaid
graph LR
    UnoTX["Uno TX (D1)"] --> R1["1kΩ"]
    R1 --> MID["Junction Point"]
    MID --> ESPRX["ESP8266 RX"]
    MID --> R2["2kΩ"]
    R2 --> GND["GND"]
    style MID fill:#ff6,stroke:#333,color:#000
```

**3 things connect at the Junction Point (same breadboard hole):**
1. Output of 1kΩ resistor (from Uno TX)
2. Wire to ESP8266 RX
3. Top of 2kΩ resistor (bottom goes to GND)

---

## Step 2: Complete Logical Diagramz

```mermaid
graph TD
    subgraph UNO["🔵 Arduino Uno"]
        UA0["A0 — Index Flex"]
        UA1["A1 — Middle Flex"]
        UA2["A2 — Ring Flex"]
        UA3["A3 — Pinky Flex"]
        UA4["A4 — MPU SDA"]
        UA5["A5 — MPU SCL"]
        UTX["TX (D1)"]
        U5V["5V"]
        UGND["GND"]
    end

    subgraph ESP["🟢 ESP8266 NodeMCU"]
        EA0["A0 — Thumb Flex"]
        ERX["RX (RX0)"]
        EVIN["VIN"]
        EGND["GND"]
    end

    subgraph DIV["⚡ Voltage Divider"]
        R1["1kΩ"]
        MID["Junction Point"]
        R2["2kΩ"]
    end

    UTX --> R1
    R1 --> MID
    MID --> ERX
    MID --> R2
    R2 --> UGND

    U5V --> EVIN
    UGND --> EGND

    style UNO fill:#1a3a5c,stroke:#4a9eff,color:#fff
    style ESP fill:#1a4a2a,stroke:#4aff6e,color:#fff
    style DIV fill:#4a3a1a,stroke:#ffaa4a,color:#fff
    style MID fill:#ff6,stroke:#333,color:#000
```

### Wire Summary

| Wire | From | To | Purpose |
|------|------|----|---------|
| 🟠 | Uno TX (D1) | → 1kΩ → Junction → ESP RX | Data through divider |
| 🟠 | Junction | → 2kΩ → GND | Pulls voltage to 3.3V |
| 🔴 | Uno 5V | → ESP VIN | Power |
| ⚫ | Uno GND | → ESP GND | Common ground |

> [!CAUTION]
> Do NOT connect ESP VIN to Uno 3.3V. The ESP needs 5V on VIN and draws up to 400mA (Uno 3.3V only gives 150mA).

---

## Step 3: Thumb Flex Sensor → ESP8266 A0

```mermaid
graph TD
    subgraph ESP["🟢 ESP8266 NodeMCU"]
        E33["3.3V"]
        EA0["A0"]
        EGND["GND"]
    end

    subgraph THUMB["🖐️ Thumb Flex Sensor"]
        FLEX["Flex Sensor"]
    end

    subgraph PULL["Pull-Down"]
        R10["10kΩ"]
    end

    E33 --> FLEX
    FLEX --> EA0
    EA0 --> R10
    R10 --> EGND

    style ESP fill:#1a4a2a,stroke:#4aff6e,color:#fff
    style THUMB fill:#5a2a1a,stroke:#ff6a4a,color:#fff
    style PULL fill:#4a3a1a,stroke:#ffaa4a,color:#fff
```

### Wiring Steps:
1. **Flex sensor leg 1** → ESP8266 **3.3V** (⚠️ NOT 5V!)
2. **Flex sensor leg 2** → ESP8266 **A0**
3. **10kΩ resistor** between ESP8266 **A0** and **GND**

---

## Checklist
- [ ] 1kΩ between Uno TX and Junction Point
- [ ] 2kΩ between Junction Point and GND
- [ ] Wire from Junction Point to ESP RX
- [ ] Uno GND → ESP GND
- [ ] Uno 5V → ESP VIN
- [ ] Thumb flex sensor between ESP 3.3V and ESP A0
- [ ] 10kΩ pull-down between ESP A0 and GND
