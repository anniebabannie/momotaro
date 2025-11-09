#!/bin/bash

# Create a temporary directory for PNG files
temp_dir=$(mktemp -d)
echo "Processing chapter-3..."

# Convert each WEBP file to PNG in numerical order with padded numbers
counter=1
for webp_file in $(ls public/assets/chapter-3/*.webp | sort -V); do
    filename=$(printf "%04d" $counter)
    # Convert to PNG and trim any existing white borders
    ffmpeg -i "$webp_file" "$temp_dir/${filename}_temp.png" -hide_banner -loglevel error
    # Trim white borders, resize to consistent dimensions, and save final PNG
    magick "$temp_dir/${filename}_temp.png" -trim +repage \
           -resize "2000x3067" -background white -gravity center -extent 2000x3067 \
           "$temp_dir/${filename}.png"
    rm "$temp_dir/${filename}_temp.png"
    ((counter++))
done

# Create output directory if it doesn't exist
mkdir -p public/pdfs

# Combine all PNG files into a single PDF
# This will fit each image to the page size without adding extra white space
magick "$temp_dir"/*.png -density 300 \
       -compress jpeg -quality 95 \
       "public/pdfs/chapter-3.pdf"

# Clean up temporary files
rm -rf "$temp_dir"

echo "Created public/pdfs/chapter-3.pdf" 