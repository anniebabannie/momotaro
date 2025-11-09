#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p public/pdfs

echo "Processing ch7 PNGs..."

# Combine all PNG files into a single PDF using ImageMagick
# This will:
# 1. Set a white background
# 2. Resize to fit within 2000x3067 while maintaining proportions
# 3. Extend the canvas with white padding to match dimensions
magick "./ch7"/*.png -background white -gravity center \
       -resize "2000x3067>" -extent "2000x3067" \
       -units PixelsPerInch -density 300 \
       "public/pdfs/chapter-7.pdf"

echo "Created public/pdfs/chapter-7.pdf" 