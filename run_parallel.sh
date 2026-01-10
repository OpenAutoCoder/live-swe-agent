#!/bin/bash
# Helper script to run live-swe-agent in parallel with copilot API

cd /root/live-swe-agent || exit 1
source venv/bin/activate || exit 1

# Run 4 parallel instances
for i in 1 2 3 4; do 
    MSWEA_COST_TRACKING='ignore_errors' \
    OPENAI_API_KEY="sk-dummy" \
    OPENAI_API_BASE="http://localhost:4141/v1" \
    mini -c config/livesweagent.yaml \
         -m openai/claude-opus-4.5 \
         -t "hello" \
         -y & 
done

# Wait for all background jobs to complete
wait

echo "All instances completed!"
