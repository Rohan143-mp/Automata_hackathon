# SYNAPSE — IoT Hardware Reference

> Actual hardware configuration for the Smart Glove.

---

## Hardware Inventory

| Component | Qty | Role |
|-----------|-----|------|
| Arduino Uno | 1 | Sensor Reader (5V logic) — **COM 9** |
| Flex Sensors | 4 | Finger bend detection |
| MPU6050 | 1 | Gyroscope / Accelerometer (tilt) |
| 10kΩ Resistors | 4 | Pull-downs for flex sensors |
| PAM8403 Amplifier | 1 | Audio output to bone transducer |
| 100µF Capacitor | 1 | Brownout protection for PAM8403 |
| Bone Conduction Transducer (8Ω) | 1 | TTS output into skull |

> **Note:** No pulse sensor is used. Heart rate / Affective Resonance is disabled.

---

## Pin Map

### Arduino Uno (COM 9)

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
| `5V` | Sensors VCC, PAM8403 | Power rail |
| `GND` | All components | **Common ground — critical** |

---

## Data Flow

```
Flex Sensors (4) ──┐
MPU6050 Gyro ──────┤ Arduino Uno
                   │
                   │ USB Serial Adapter (COM 9) @ 115200 baud
                   │ Format: <Index,Middle,Ring,Pinky,GX,GY>
                   ▼
              PC Hub (serial_to_ws.py)
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
| Index | 0 | Uno A0 |
| Middle | 1 | Uno A1 |
| Ring | 2 | Uno A2 |
| Pinky | 3 | Uno A3 |
| Gyro X | 4 | Uno MPU6050 |
| Gyro Y | 5 | Uno MPU6050 |

**Packet:** `<F1,F2,F3,F4,GX,GY>` (6 values, no heart rate)

---

## Network Ports

| Connection | Protocol | Port |
|-----------|----------|------|
| PC Hub (serial bridge) | WebSocket | `81` |
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
