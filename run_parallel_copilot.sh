#!/bin/bash
# Parallel execution script for live-swe-agent with Copilot API proxy
# This script runs 4 parallel instances of live-swe-agent using the Copilot API

set -e

cd /root/live-swe-agent || exit 1
source venv/bin/activate || exit 1

echo "Starting 4 parallel instances of live-swe-agent..."
echo "=================================================="
echo "API Endpoint: http://localhost:4141/v1"
echo "Model: openai/claude-opus-4.5"
echo "Config: config/livesweagent_planning.yaml"
echo "=================================================="
echo ""

# Run 4 parallel instances
for i in 1 2 3 4; do 
    echo "Starting instance $i..."
    MSWEA_COST_TRACKING='ignore_errors' \
    OPENAI_API_KEY="sk-dummy" \
    OPENAI_API_BASE="http://localhost:4141/v1" \
    mini -c config/livesweagent_planning.yaml \
         -m openai/claude-opus-4.5 \
         -t "hello" \
         -y & 
done

echo ""
echo "All 4 instances started in background"
echo "Waiting for all instances to complete..."
echo ""

# Wait for all background jobs to complete
wait

echo ""
echo "=================================================="
echo "All instances completed!"
echo "=================================================="
