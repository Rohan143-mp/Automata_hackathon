from mcp.server.fastmcp import FastMCP
import json
import random
import time
import ollama
import docker
import os

# Create an MCP server
mcp = FastMCP("SYNAPSE Hub Services")

# Initialize Docker client
try:
    docker_client = docker.from_env()
except Exception:
    docker_client = None

@mcp.tool()
def list_ollama_models() -> str:
    """
    Lists all models currently available in the local Ollama instance.
    """
    try:
        models = ollama.list()
        return json.dumps(models, indent=2)
    except Exception as e:
        return f"Error connecting to Ollama: {e}"

@mcp.tool()
def pull_ollama_model(model_name: str) -> str:
    """
    Pulls a new model from the Ollama library.
    """
    try:
        ollama.pull(model_name)
        return f"Successfully pulled {model_name}"
    except Exception as e:
        return f"Error pulling model: {e}"

@mcp.tool()
def simulate_glove_data() -> str:
    """
    Generates a mock 7D vector packet from the Smart Glove.
    Format: <Thumb, Index, Middle, Ring, Pinky, GyroX, GyroY, HeartRate>
    """
    fingers = [random.randint(0, 100) for _ in range(5)]
    gyro = [random.uniform(-1.0, 1.0) for _ in range(2)]
    hr = random.randint(60, 120)
    
    packet = f"<{','.join(map(str, fingers))},{gyro[0]:.2f},{gyro[1]:.2f},{hr}>"
    return f"Generated Glove Packet: {packet}"

@mcp.tool()
def intent_playground(shorthand: str, context: str = "") -> str:
    """
    Tests the expansion of shorthand sign language phrases using the local Ollama LLM.
    """
    prompt = f"Convert this sign language shorthand: '{shorthand}' into a full, polite sentence. "
    if context:
        prompt += f"Context from the classroom: '{context}'"
    
    try:
        # Using Llama3 as the default internal model for intent expansion
        response = ollama.chat(model='llama3', messages=[
            {'role': 'user', 'content': prompt},
        ])
        return response['message']['content']
    except Exception as e:
        return f"Simulated Intent Prompt (Ollama Down/Missing llama3): {prompt}\nError: {e}"

@mcp.tool()
def latency_probe() -> str:
    """
    Measures simulated end-to-end latency (Glove -> PC -> App).
    """
    # Hardware/Serial (~20ms) + Whisper Processing (~100ms) + Ollama (~300ms) + Network (~10ms)
    total_latency = 430 + random.randint(-50, 50)
    return json.dumps({
        "status": "online",
        "total_latency_ms": total_latency,
        "components": {
            "serial": 20,
            "whisper": 100,
            "ollama": 300,
            "websocket": 10
        }
    }, indent=2)

@mcp.tool()
def get_docker_status() -> str:
    """
    Lists all Docker containers and their current status.
    """
    if not docker_client:
        return "Docker client not initialized. Ensure Docker is running."
    
    try:
        containers = docker_client.containers.list(all=True)
        result = []
        for c in containers:
            result.append({
                "name": c.name,
                "status": c.status,
                "image": str(c.image.tags[0]) if c.image.tags else "unknown"
            })
        return json.dumps(result, indent=2)
    except Exception as e:
        return f"Error connecting to Docker: {e}"

@mcp.tool()
def system_check() -> str:
    """
    Performs a health check on local services (Ollama & Docker).
    """
    ollama_ok = False
    try:
        ollama.list()
        ollama_ok = True
    except:
        pass
        
    docker_ok = docker_client is not None
    try:
        if docker_ok:
            docker_client.ping()
    except:
        docker_ok = False
        
    return json.dumps({
        "ollama": "running" if ollama_ok else "offline",
        "docker": "running" if docker_ok else "offline",
        "timestamp": time.ctime()
    }, indent=2)

if __name__ == "__main__":
    mcp.run()
