#!/bin/bash

# Set explicit input and output paths
INPUT_PDF="$(pwd)/chapter-7.pdf"
OUTPUT_PDF="$(pwd)/chapter-7-resized.pdf"

echo "Input PDF: $INPUT_PDF"
echo "Output will be saved to: $OUTPUT_PDF"

# Check if input PDF exists
if [ ! -f "$INPUT_PDF" ]; then
    echo "Error: Cannot find $INPUT_PDF"
    exit 1
fi

# Process PDF
echo "Processing PDF..."
magick "$INPUT_PDF" \
       -density 300 \
       -resize "2007x3072" \
       -background white \
       -gravity center \
       -extent 2007x3072 \
       -quality 100 \
       -compress lossless \
       "$OUTPUT_PDF"

echo "Created $OUTPUT_PDF" 