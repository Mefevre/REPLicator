#!/bin/bash

# Select mode with options
while getopts "ea" opt; do
    case $opt in
        "e") echo "Mode Expert (option $OPTARG)";;
        "a") echo "Mode Assisté (option $OPTARG)";;
    esac
done