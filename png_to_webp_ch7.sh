#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

# Directory containing chapter 7 PNG images
SRC_DIR="public/assets/chapter-7"
# Quality (0-100) override with: QUALITY=90 ./png_to_webp_ch7.sh
QUALITY="${QUALITY:-85}"

if ! command -v cwebp >/dev/null 2>&1; then
  echo "Error: 'cwebp' not found. Install webp tools (e.g. 'brew install webp')." >&2
  exit 1
fi

# Handle both .png and .PNG
found=false
for img in "$SRC_DIR"/*.png "$SRC_DIR"/*.PNG; do
  [ -e "$img" ] || continue
  found=true
  base="${img%.*}"
  out="$base.webp"
  if [ -f "$out" ] && [ "$img" -ot "$out" ]; then
    echo "Skip (up-to-date): $img"
    continue
  fi
  echo "Converting: $img -> $out (q=$QUALITY)"
  cwebp -quiet -q "$QUALITY" "$img" -o "$out"
done

if [ "$found" = false ]; then
  echo "No PNG files found in $SRC_DIR" >&2
  exit 2
fi

echo "Done."