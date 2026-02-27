# SYNAPSE — IoT Hardware Reference

> Actual hardware configuration for the Smart Glove.

---

## Hardware Inventory

| Component | Qty | Role |
|-----------|-----|------|
| Arduino Uno | 1 | Sensor Reader (5V logic) |
| ESP8266 NodeMCU | 1 | WiFi Gateway (3.3V logic) |
| Flex Sensors | 5 | Finger bend detection |
| MPU6050 | 1 | Gyroscope / Accelerometer (tilt) |
| 10kΩ Resistors | 5 | Pull-downs for flex sensors |
| 1kΩ Resistor | 1 | Voltage divider (serial bridge) |
| 2kΩ Resistor | 1 | Voltage divider (serial bridge) |
| PAM8403 Amplifier | 1 | Audio output to bone transducer |
| 100µF Capacitor | 1 | Brownout protection for PAM8403 |
| Bone Conduction Transducer (8Ω) | 1 | TTS output into skull |

> **Note:** No pulse sensor is used. Heart rate / Affective Resonance is disabled.

---

## Pin Map

### Arduino Uno

| Pin | Connected To | Notes |
|-----|-------------|-------|
| `A0` | Index Flex Sensor | + 10kΩ pull-down |
| `A1` | Middle Flex Sensor | + 10kΩ pull-down |
| `A2` | Ring Flex Sensor | + 10kΩ pull-down |
| `A3` | Pinky Flex Sensor | + 10kΩ pull-down |
| `A4` | MPU6050 SDA | I2C Data |
| `A5` | MPU6050 SCL | I2C Clock |
| `TX` (D1) | → Voltage Divider → ESP8266 RX | Serial data out |
| `RX` (D0) | ← ESP8266 TX (optional) | Feedback line |
| `5V` | Sensors VCC, ESP8266 VIN, PAM8403 | Power rail |
| `GND` | All components | **Common ground — critical** |

### ESP8266 NodeMCU

| Pin | Connected To | Notes |
|-----|-------------|-------|
| `A0` | Thumb Flex Sensor | + 10kΩ pull-down (only analog pin on ESP) |
| `RX` (RX0) | ← Voltage Divider ← Uno TX | Receives sensor CSV |
| `TX` (TX0) | → Uno RX (optional) | Feedback line |
| `VIN` | ← Uno 5V | Powered from Uno |
| `GND` | Common Ground | Shared with Uno |

---

## Serial Bridge (5V → 3.3V)

The Uno operates at 5V and the ESP8266 RX is 3.3V — a voltage divider is **required**.

```
Uno TX (D1) ──[ 1kΩ ]──┬── ESP8266 RX
                        │
                     [ 2kΩ ]
                        │
                       GND
```

---

## Data Flow

```
Flex Sensors (4) ──┐
MPU6050 Gyro ──────┤ Arduino Uno
                   │
                   │ Serial @ 115200 baud
                   │ Format: <Index,Middle,Ring,Pinky,GX,GY>
                   ▼
              ESP8266 NodeMCU
                   │
                   │ 1. Reads Thumb flex from its own A0
                   │ 2. Prepends into: <Thumb,Index,Middle,Ring,Pinky,GX,GY>
                   │ 3. Broadcasts via WiFi WebSocket on port 81
                   ▼
              PC Hub (main_server.py)
                   │
                   │ 1. Gesture matching (cosine similarity)
                   │ 2. Ollama LLM intent expansion
                   │ 3. TTS voice output (fixed speed, no HR)
                   │ 4. Broadcast to Flutter App on port 82
                   ▼
              Flutter App (Dashboard)
```

### Data Format

| Field | Index | Source |
|-------|-------|--------|
| Thumb | 0 | ESP8266 A0 |
| Index | 1 | Uno A0 |
| Middle | 2 | Uno A1 |
| Ring | 3 | Uno A2 |
| Pinky | 4 | Uno A3 |
| Gyro X | 5 | Uno MPU6050 |
| Gyro Y | 6 | Uno MPU6050 |

**Packet:** `<F1,F2,F3,F4,F5,GX,GY>` (7 values, no heart rate)

---

## Network Ports

| Connection | Protocol | Port |
|-----------|----------|------|
| ESP8266 → PC Hub | WebSocket | `81` |
| PC Hub → Flutter App | WebSocket | `82` |
| Flutter Mic → PC Hub (Whisper) | WebSocket | `8765` |

---

## WiFi Config

Update these in `synapse_wifi/synapse_wifi.ino`:

```cpp
const char* WIFI_SSID     = "YOUR_WIFI_NAME";
const char* WIFI_PASSWORD  = "YOUR_WIFI_PASSWORD";
```

---

## Audio Output (Bone Conduction)

```
PC 3.5mm Jack ──→ PAM8403 Audio IN
Arduino 5V    ──→ PAM8403 VCC  (+ 100µF cap across 5V/GND)
Arduino GND   ──→ PAM8403 GND
PAM8403 OUT   ──→ Bone Transducer (8Ω)
```

> ⚠️ Add a **100µF electrolytic capacitor** near PAM8403 power pins to prevent brownout resets.
