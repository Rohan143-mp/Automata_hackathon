import asyncio
import websockets
import time

# Import our custom logic services
from services.gesture_engine import match_gesture
from services.intent_service import generate_fluent_speech
from services.app_sync_service import start_app_sync_server, broadcast_telemetry

GLOVE_WS_URL = "ws://localhost:81"

# To prevent spamming the LLM and the Telemetry when a gesture is held
last_match_time = 0
MATCH_COOLDOWN = 1.0 # 1 second before matching again

def get_recent_transcript():
    """
    Mocks the Whisper transcript for Phase 3.
    (Phase 1 Whisper integration happens in Phase 5).
    """
    return "The teacher is explaining photosynthesis."

async def ingest_glove_data():
    """Connects to the Smart Glove (or Mock Server) and pipes vectors to the intent engine."""
    global last_match_time
    
    while True: # Auto-reconnect loop
        print(f"[PC Hub] Attempting connection to Glove Data Stream at {GLOVE_WS_URL}...")
        try:
             async with websockets.connect(GLOVE_WS_URL) as websocket:
                print(f"[PC Hub] Connected to Glove Data Stream!")
                
                async for message in websocket:
                    # Expecting format: <F1,F2,F3,F4,F5,GX,GY,HR>
                    msg = message.strip()
                    if msg.startswith("<") and msg.endswith(">"):
                        data_str = msg[1:-1]
                        parts = data_str.split(',')
                        
                        if len(parts) == 8:
                            try:
                                # Parse out 7D vector
                                vector = [float(p) for p in parts[:7]]
                                hr = int(parts[7])
                                
                                current_time = time.time()
                                
                                # Attempt a match if cooldown has passed
                                if current_time - last_match_time > MATCH_COOLDOWN:
                                    intent = match_gesture(vector, threshold=0.92)
                                    
                                    if intent:
                                        last_match_time = current_time
                                        print(f"\n[Glove Match]: Hand state identified as '{intent.upper()}'")
                                        
                                        # 1. Grab Context
                                        context = get_recent_transcript()
                                        
                                        # 2. Ask Ollama for fluent speech
                                        print(f"[Ollama] Translating intent using context: '{context}'...")
                                        speech = generate_fluent_speech(intent, context)
                                        print(f"[Speech Output]: \"{speech}\"")
                                        
                                        # 3. Broadcast to the Flutter UI
                                        await broadcast_telemetry(intent, speech)
                                        
                            except ValueError as e:
                                print(f"Value Parsing Error: {e} with payload {data_str}")
        
        except (websockets.exceptions.ConnectionClosedError, ConnectionRefusedError):
            print("[PC Hub] Disconnected from Glove. Retrying in 2 seconds...")
            await asyncio.sleep(2)

async def main():
    print("=====================================================")
    print("      SYNAPSE PC HUB: NEURAL-INTENT ENGINE           ")
    print("=====================================================")
    
    # Start the App Telemetry Server concurrently (Port 82)
    # The server runs in the background while we ingest glove data
    async with await start_app_sync_server(port=82):
        print("[PC Hub] App Telemetry Server running.")
        
        # Connect to Glove logic (Port 81)
        await ingest_glove_data()

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n[PC Hub] Shutting down.")
