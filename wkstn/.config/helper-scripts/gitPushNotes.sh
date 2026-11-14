#!/bin/bash

# Position inside notes directory
cd /home/bigfella/Documents/notes

# Trap Ctrl+C to exit gracefully
trap 'echo -e "\nAborted."; exit 1' INT

# Take user input for commit message
read -p "Write commit message: " commitMessage

# Can't go further without proper comment
if [[ -z "$commitMessage" ]]; then
    echo "No commit message provided. Exiting."
    exit 1
fi

# Git magic
git add . && git commit -m "$commitMessage" && git push origin main
