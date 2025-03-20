#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <usernames_file> <passwords_file>"
    exit 1
fi

# Check if both files exist
if [ ! -f "$1" ] || [ ! -f "$2" ]; then
    echo "One or both of the files do not exist"
    exit 1
fi

# Create a new file to store username-password pairs
output_file="username_password_pairs.txt"
touch "$output_file"

# Iterate over each username
while IFS= read -r username || [ -n "$username" ]; do
    # Remove trailing newline characters
    username=$(echo "$username" | tr -d '\r\n')

    # Iterate over each password
    while IFS= read -r password || [ -n "$password" ]; do
        # Remove trailing newline characters
        password=$(echo "$password" | tr -d '\r\n')

        # Write username and password separated by a colon to the output file
	echo "$username:$password"
        echo "$username:$password" >> "$output_file"
    done < "$2"
done < "$1"

echo "Username-password pairs have been written to $output_file"
