# SYNAPSE — Complete Wiring & Connection Diagrams

All connection diagrams for the Split-Brain IoT Glove and full system.

---

## 1. Full System Architecture

The end-to-end data flow from Glove → PC Hub → Flutter App.

![Full SYNAPSE system architecture showing Glove, PC Hub, and Flutter App](C:\Users\Administrator\.gemini\antigravity\brain\95d7d52b-603a-408a-b503-d63b43f9651c\system_architecture_1772105919883.png)

**Ports:**
| Connection | Protocol | Port |
|---|---|---|
| Glove → PC Hub | WebSocket | `81` |
| PC Hub → Flutter App | WebSocket | `82` |
| Flutter Mic → PC Hub (Whisper) | WebSocket | `8765` |

---

## 2. Arduino Nano — Sensor Wiring

5 flex sensors + MPU6050 gyroscope + pulse sensor all wired to the Nano.

![Arduino Nano wiring with flex sensors, MPU6050, and pulse sensor](C:\Users\Administrator\.gemini\antigravity\brain\95d7d52b-603a-408a-b503-d63b43f9651c\arduino_sensor_wiring_1772105829068.png)

**Pin Map:**
| Sensor | Pin | Notes |
|---|---|---|
| Thumb Flex | `A0` | + 10kΩ pull-down |
| Index Flex | `A1` | + 10kΩ pull-down |
| Middle Flex | `A2` | + 10kΩ pull-down |
| Ring Flex | `A3` | + 10kΩ pull-down |
| Pinky Flex | `A6` | + 10kΩ pull-down |
| Pulse Sensor | `A7` | Analog heart rate |
| MPU6050 SDA | `A4` | I2C Data |
| MPU6050 SCL | `A5` | I2C Clock |

---

## 3. Serial Bridge — Nano ↔ ESP8266

The voltage divider bridge between the 5V Nano and 3.3V ESP8266.

![Serial bridge wiring between Arduino Nano and ESP8266 with voltage divider](C:\Users\Administrator\.gemini\antigravity\brain\95d7d52b-603a-408a-b503-d63b43f9651c\serial_bridge_wiring_1772105856957.png)

**Circuit:**
```
Nano TX (D1) ──[ 1kΩ ]──+── ESP8266 RX
                         │
                      [ 2kΩ ]
                         │
                        GND
```

| Nano Pin | → | ESP8266 Pin | Notes |
|---|---|---|---|
| `TX` (D1) | via divider | `RX` (RX0) | Data flow (5V → 3.3V) |
| `RX` (D0) | direct | `TX` (TX0) | Optional feedback |
| `5V` | direct | `VIN` | Powers ESP from Nano |
| `GND` | direct | `GND` | **Must be common** |

---

## 4. Audio Output — Bone Conduction

PAM8403 amplifier driving the bone transducer from PC audio.

![PAM8403 amplifier wiring to bone conduction transducer](C:\Users\Administrator\.gemini\antigravity\brain\95d7d52b-603a-408a-b503-d63b43f9651c\audio_output_wiring_1772105889648.png)

**Connections:**
| From | To | Notes |
|---|---|---|
| Arduino `5V` | PAM8403 `VCC` | + **100µF cap** across rails |
| Arduino `GND` | PAM8403 `GND` | Common ground |
| 3.5mm Tip/Ring | PAM8403 Audio IN | Audio from PC Hub TTS |
| 3.5mm Sleeve | PAM8403 Audio GND | Signal ground |
| PAM8403 OUT | Bone Transducer (8Ω) | Speaker output |

> [!CAUTION]
> Add a **100µF electrolytic capacitor** across the PAM8403 power input to prevent brownout resets during loud bass spikes.
