#!/bin/bash

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "No components specified. Please provide components to start."
    exit 1
fi

for component in "$@"; do
    echo "start" $component
    cd $component && sh ./_stop.sh && cd ..
done