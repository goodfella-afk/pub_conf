#!/bin/bash

# Position inside notes directory
cd /home/bigfella/Documents/notes

# Ask if you want to proceed with pull and set default value to Y
read -p "This is going to pull the changes made on remote branch, do you want to proceed? [Y/n]: " choice

# Git magic if Y
if [[ $choice == "Y" || $choice == "y" || $choice == "" ]]; then
    git pull origin main
else
    echo "Haven't pulled. Bye"
fi 
