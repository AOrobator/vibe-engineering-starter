#!/bin/bash
# Detect active worklog and prompt Claude to restore context

if [ -f "WORKLOG.md" ]; then
  echo "WORKLOG.md detected. Read it to restore context."
fi
