#!/bin/bash

# the final folder where we will store the gold data
DEST_DIR="/mnt/g/MAIN_syllybus/courses/cde_assignments/assig_2/scripts/first_bash_script"

# Strips the path portion of the URL and only get the file name part
FILENAME=$(basename "$CSV_URL")

echo "Start downloading the file"
# 5. Download the CSV file, and save it into the raw sub-folder
curl -L "$CSV_URL" -o "$DEST_DIR/raw/$FILENAME"

# Check if the file gets downloaded successfully
if ! curl -L "$CSV_URL" -o "$DEST_DIR/raw/$FILENAME"; then
    echo "Failed to download the file"
    exit 1
fi
# check if the file exist in the raw folder
if [[ -s "$DEST_DIR/raw/$FILENAME" ]]; then
    echo "The file got downloaded successfully"
else
    echo "Error occurred, the file does not exist or is empty"
    exit 1
fi

# Transform the data by making the "Variable_code" column to be "variable_code" and select the first, ninth, fifth, and sixth fields
# then save the transformed data into the transformed folder
cut -d ',' -f 1,9,5,6 "$DEST_DIR/raw/$FILENAME" | sed -e '1s/Variable_code/variable_code/' > "$DEST_DIR/Transformed/2023_year_finance.csv"

# check if the transformed folder received the file correctly
if [[ -s "$DEST_DIR/Transformed/" ]]; then
    echo "The file got transformed successfully"
else
    echo "Error occurred, The transformed file does not exist"
    exit 1
fi

# Move the final cleaned data from the transformed folder into the Gold folder
mv "$DEST_DIR/Transformed/2023_year_finance.csv" "$DEST_DIR/Gold/final.csv"

# Check if the previous process went well by checking the Gold folder itself
if [[ -s "$DEST_DIR/Gold/" ]]; then
    echo "The file exists"
else
    echo "Error occurred, The file has not been loaded"
    exit 1
fi
