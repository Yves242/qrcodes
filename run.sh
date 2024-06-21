#!/bin/bash

# Arrays of prefixes and corresponding numbers
prefixes=("A" "CD" "MC" "CM" "HC" "M")   # Array of prefixes
numbers=(100 100 100 100 100 100)        # Array of corresponding numbers of QR codes to generate

# Function to generate QR codes for a given prefix
generate_qr_for_prefix() {
    local prefix="$1"
    local max_number="$2"

    # Loop through numbers from 1 to max_number
    for ((n=1; n<=max_number; n++)); do
        # Format number with leading zeros
        formatted_number=$(printf "%06d" "$n")

        # Call another script and pass values as arguments
        ./gen.image.qr.params.sh "$prefix" "$formatted_number"
    done
}

# Loop through the arrays and generate QR codes for each prefix
for ((i=0; i<${#prefixes[@]}; i++)); do
    prefix="${prefixes[$i]}"
    number="${numbers[$i]}"
    
    # Call function to generate QR codes for current prefix
    generate_qr_for_prefix "$prefix" "$number"
done
