#!/bin/bash

# Set explicit input and output paths
INPUT_PDF="$(pwd)/chapter-7.pdf"
OUTPUT_PDF="$(pwd)/chapter-7-reversed.pdf"

# Create a temporary directory
temp_dir=$(mktemp -d)

echo "Input PDF: $INPUT_PDF"
echo "Output will be saved to: $OUTPUT_PDF"

# Check if input PDF exists
if [ ! -f "$INPUT_PDF" ]; then
    echo "Error: Cannot find $INPUT_PDF"
    exit 1
fi

# Extract pages to individual images and wait for completion
echo "Extracting pages..."
magick "$INPUT_PDF" "$temp_dir/page-%04d.png"

# Verify pages were extracted
page_count=$(ls "$temp_dir"/*.png 2>/dev/null | wc -l)
if [ "$page_count" -eq 0 ]; then
    echo "Error: No pages were extracted from the PDF"
    rm -rf "$temp_dir"
    exit 1
fi

echo "Found $page_count pages, reversing order..."

# Create a new PDF with pages in reverse order
magick "$temp_dir"/page-*.png -reverse -density 300 \
       -compress jpeg -quality 95 \
       "$OUTPUT_PDF"

# Clean up
rm -rf "$temp_dir"

echo "Created $OUTPUT_PDF with reversed page order" 