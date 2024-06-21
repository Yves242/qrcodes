#!/bin/bash

# Check if prefix and number are provided as arguments
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <prefix> <number>"
  echo "Example: $0 A 5"
  exit 1
fi

# Get the prefix and number from the arguments
prefix=$1
number=$2

# remove leading zeroes
number="${number#"${number%%[!0]*}"}"

# Validate the number is within the range
if ! [[ $number =~ ^[1-9][0-9]*$ ]] || [ "$number" -lt 1 ] || [ "$number" -gt 999999 ]; then
  echo "Please provide a valid number between 1 and 999999."
  exit 1
fi

# Format the number to six digits with leading zeros
formatted_number=$(printf "%s-%06d" $prefix $number)

# Create the directory if it doesn't exist to save QR codes
output_dir="./$prefix"
mkdir -p "$output_dir"

# Set the output image filename with path
output_image="${output_dir}/qrcode_${formatted_number}.png"

# Check if the file already exists
if [ -f "$output_image" ]; then
  echo "QR code already exists: $output_image"
else
  # Generate QR code
  qrencode -s 50 -o "$output_image" "$formatted_number"
  
  # echo "QR code generated for: $formatted_number"
  # echo "Image saved as: $output_image"
fi
