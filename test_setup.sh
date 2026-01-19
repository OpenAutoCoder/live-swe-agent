#!/bin/bash
# Test script to verify live-swe-agent setup with Copilot API proxy

cd /root/live-swe-agent || exit 1
source venv/bin/activate || exit 1

echo "Testing live-swe-agent with Copilot API proxy..."
echo "================================================"
echo ""

# Create a simple test directory
TEST_DIR="/tmp/live-swe-test-$$"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# Create a simple test file
cat > test.py << 'EOF'
def hello():
    print("Hello World")

hello()
EOF

echo "Test directory: $TEST_DIR"
echo "Running single instance test..."
echo ""

# Test with a simple task
MSWEA_COST_TRACKING='ignore_errors' \
OPENAI_API_KEY="sk-dummy" \
OPENAI_API_BASE="http://localhost:4141/v1" \
mini -c /root/live-swe-agent/config/livesweagent_planning.yaml \
     -m openai/claude-opus-4.5 \
     -t "List the files in the current directory" \
     -y

echo ""
echo "================================================"
echo "Test completed!"
echo "Cleaning up test directory..."
rm -rf "$TEST_DIR"
