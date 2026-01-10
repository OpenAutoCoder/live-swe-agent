#!/bin/bash
# Status check script for live-swe-agent setup

echo "════════════════════════════════════════════════════════════════"
echo "  LIVE-SWE-AGENT SETUP STATUS CHECK"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Check if in correct directory
if [ ! -d "/root/live-swe-agent" ]; then
    echo "❌ Live-SWE-Agent directory not found at /root/live-swe-agent"
    exit 1
fi

echo "✓ Live-SWE-Agent directory: /root/live-swe-agent"
echo ""

# Check virtual environment
if [ ! -d "/root/live-swe-agent/venv" ]; then
    echo "❌ Virtual environment not found"
    exit 1
fi
echo "✓ Virtual environment: venv/"
echo ""

# Check mini-swe-agent installation
cd /root/live-swe-agent
source venv/bin/activate 2>/dev/null

if ! command -v mini &> /dev/null; then
    echo "❌ mini-swe-agent not installed"
    exit 1
fi

MINI_VERSION=$(mini --help 2>&1 | grep "mini-swe-agent version" | awk '{print $5}')
echo "✓ mini-swe-agent version: $MINI_VERSION"
echo ""

# Check config files
if [ ! -f "config/livesweagent_planning.yaml" ]; then
    echo "❌ Config file not found: config/livesweagent_planning.yaml"
    exit 1
fi
echo "✓ Config files available:"
for config in config/*.yaml; do
    echo "  - $(basename $config)"
done
echo ""

# Check Copilot API proxy
echo "Checking Copilot API proxy..."
if curl -s http://localhost:4141/v1/models > /dev/null 2>&1; then
    echo "✓ Copilot API proxy is running on http://localhost:4141"
    
    # Count available models
    MODEL_COUNT=$(curl -s http://localhost:4141/v1/models | grep -o '"id"' | wc -l)
    echo "  Available models: $MODEL_COUNT"
    echo ""
    echo "  Key models:"
    echo "  - openai/claude-opus-4.5"
    echo "  - openai/claude-sonnet-4.5"
    echo "  - openai/gpt-5.1-codex-max"
    echo "  - openai/gemini-3-pro-preview"
else
    echo "❌ Copilot API proxy is NOT running"
    echo ""
    echo "  Start it with:"
    echo "  npx copilot-api-plus@latest start --rate-limit 4 --wait"
    exit 1
fi

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  ALL CHECKS PASSED! ✓"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Ready to run:"
echo "  - Single instance: ./test_setup.sh"
echo "  - Parallel (4x):   ./run_parallel_copilot.sh"
echo ""
echo "Or use manual commands (see QUICK_START.txt)"
echo ""
