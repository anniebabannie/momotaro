#!/bin/bash

# Define dimensions (in inches)
WIDTH=6.69
HEIGHT=10.24

# Calculate aspect ratio (multiply by 100 to work with integers)
TARGET_RATIO=$(echo "scale=4; $HEIGHT/$WIDTH*100" | bc)

# Create output directory if it doesn't exist
mkdir -p public/pdfs

# Process each chapter directory
for chapter_dir in public/assets/chapter-*; do
    chapter_name=$(basename "$chapter_dir")
    echo "Processing $chapter_name..."

    # Create a temporary directory for PNG files
    temp_dir=$(mktemp -d)

    # Convert each WEBP file to PNG in numerical order with padded numbers
    counter=1
    for webp_file in $(ls "$chapter_dir"/*.webp | sort -V); do
        filename=$(printf "%04d" $counter)
        ffmpeg -i "$webp_file" "$temp_dir/${filename}.png" -hide_banner -loglevel error
        ((counter++))
    done

    # Combine all PNG files into a single PDF using ImageMagick
    # This will:
    # 1. Set a white background
    # 2. Resize to fit within the aspect ratio while maintaining proportions
    # 3. Extend the canvas with white padding to match the target ratio
    magick "$temp_dir"/*.png -background white -gravity center \
           -resize "2000x3067>" -extent "2000x3067" \
           -units PixelsPerInch -density 300 \
           "public/pdfs/${chapter_name}.pdf"

    # Clean up temporary files
    rm -rf "$temp_dir"

    echo "Created public/pdfs/${chapter_name}.pdf"
done