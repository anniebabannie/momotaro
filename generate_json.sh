#!/bin/zsh

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 start end"
  exit 1
fi

# Assign arguments to variables
start=$1
end=$2

# Loop to create .json files from start to end
for (( i=$start; i<=$end; i++ )); do
  # File name
  filename="page_${i}.json"
  
  # Create the .json file with the desired keys
  echo "{\"page\": $i, \"alt\": \"\"}" > $filename
done

echo "JSON files from ${start} to ${end} have been created in the current directory."
