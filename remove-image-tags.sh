#!/bin/bash

# Script to remove imageTag from applications section in YAML files
# Usage: ./remove-image-tags.sh [file1.yaml] [file2.yaml] ...
# If no files specified, processes all .yaml files in projects/ directory

set -e

# Function to remove imageTag from a single file
remove_image_tag() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        echo "Warning: File $file not found, skipping..."
        return 1
    fi
    
    echo "Processing $file..."
    
    # Use sed to remove imageTag lines from applications
    sed '/^[[:space:]]*imageTag:/d' "$file" > "${file}.tmp"
    
    # Replace original file
    mv "${file}.tmp" "$file"
    
    echo "✓ Removed imageTag from $file"
}

# Main execution
if [[ $# -eq 0 ]]; then
    # No arguments provided, process all .yaml files in projects/ directory
    echo "No files specified, processing all .yaml files in projects/ directory..."
    
    if [[ ! -d "projects" ]]; then
        echo "Error: projects/ directory not found"
        exit 1
    fi
    
    for file in projects/*.yaml; do
        if [[ -f "$file" ]]; then
            remove_image_tag "$file"
        fi
    done
else
    # Process specified files
    for file in "$@"; do
        remove_image_tag "$file"
    done
fi

echo "Script completed successfully!"