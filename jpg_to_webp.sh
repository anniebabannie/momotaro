#!/bin/bash

# Check if a directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Set the input directory
input_dir="$1"

# Loop through all JPEG files in the given directory
for file in "$input_dir"/*.jpg "$input_dir"/*.jpeg; do
  # Check if the file exists (in case no .jpg or .jpeg files are found)
  if [ -f "$file" ]; then
    # Get the file name without extension
    filename=$(basename "$file" | sed 's/\(.*\)\..*/\1/')

    # Convert the file to WebP format using ffmpeg
    ffmpeg -i "$file" -qscale 75 "$input_dir/${filename}.webp"
    
    echo "Converted: $file -> ${filename}.webp"
  fi
done

echo "Conversion complete!"
