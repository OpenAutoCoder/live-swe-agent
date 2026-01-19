# Live-SWE-Agent Setup with Copilot API Proxy

This setup allows you to use live-swe-agent with the Copilot API proxy.

## Prerequisites

1. **Copilot API Proxy** must be running on port 4141:
   ```bash
   npx copilot-api-plus@latest start --rate-limit 4 --wait
   ```

## Setup Complete ✓

The environment has been set up with:
- Virtual environment created at `/root/live-swe-agent/venv`
- mini-swe-agent installed (v1.17.3)
- Configuration files available in `/root/live-swe-agent/config/`

## Usage

### Quick Test

Run a single instance test to verify the setup:
```bash
cd /root/live-swe-agent
./test_setup.sh
```

### Single Instance

Run a single instance with your own task:
```bash
cd /root/live-swe-agent
source venv/bin/activate

MSWEA_COST_TRACKING='ignore_errors' \
OPENAI_API_KEY="sk-dummy" \
OPENAI_API_BASE="http://localhost:4141/v1" \
mini -c config/livesweagent_planning.yaml \
     -m openai/claude-opus-4.5 \
     -t "YOUR_TASK_HERE" \
     -y
```

### Parallel Execution (4 instances)

Run 4 parallel instances using the Copilot API proxy:
```bash
cd /root/live-swe-agent
./run_parallel_copilot.sh
```

Or manually:
```bash
cd /root/live-swe-agent
source venv/bin/activate

for i in 1 2 3 4; do 
    MSWEA_COST_TRACKING='ignore_errors' \
    OPENAI_API_KEY="sk-dummy" \
    OPENAI_API_BASE="http://localhost:4141/v1" \
    mini -c config/livesweagent_planning.yaml \
         -m openai/claude-opus-4.5 \
         -t "hello" \
         -y & 
done

wait
```

## Configuration Files

Available in `/root/live-swe-agent/config/`:
- `livesweagent.yaml` - Basic configuration
- `livesweagent_planning.yaml` - Planning-enhanced configuration (recommended)
- `livesweagent_swebench.yaml` - SWE-bench Verified configuration
- `livesweagent_swebench_pro.yaml` - SWE-Bench Pro configuration

## Available Models via Copilot API

The Copilot API proxy supports these models:
- `openai/claude-opus-4.5` (recommended for best performance)
- `openai/claude-sonnet-4.5`
- `openai/gpt-5.1-codex-max`
- `openai/gpt-5.2`
- `openai/gpt-4.1`
- `openai/gemini-3-pro-preview`

## Environment Variables

- `OPENAI_API_KEY="sk-dummy"` - Dummy key for local proxy
- `OPENAI_API_BASE="http://localhost:4141/v1"` - Local Copilot API proxy endpoint
- `MSWEA_COST_TRACKING='ignore_errors'` - Disable cost tracking for local use

## Troubleshooting

### Check if Copilot API is running:
```bash
curl http://localhost:4141/v1/models
```

### Check available models:
```bash
curl http://localhost:4141/v1/models | jq '.data[].id'
```

### Activate virtual environment:
```bash
cd /root/live-swe-agent
source venv/bin/activate
```

### Check mini-swe-agent version:
```bash
mini --version
```

## Notes

- The Copilot API proxy has a rate limit of 4 requests, matching the 4 parallel instances
- Tasks can be customized by modifying the `-t` parameter
- Configuration can be changed using the `-c` parameter
- Model can be changed using the `-m` parameter
- The `-y` flag automatically confirms prompts
