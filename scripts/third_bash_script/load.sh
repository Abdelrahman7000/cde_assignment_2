#!/bin/bash


# The path where the data resides
CSV_DIR='/mnt/g/MAIN_syllybus/courses/cde_assignments/assig_2/scripts/third_bash_script/data_files'
# The container name in docker
CONTAINER_NAME='postgres'
# the database name
DB_NAME='posey'
# the database user used to login into the database server
DB_USER='postgres'


# Copy CSVs into the container's /tmp folder
# Loop over the csv files in the specified path
for csv_file in "$CSV_DIR"/*.csv; do
    # Extracts the filename from the full URL or path
    filename=$(basename -- "$csv_file")
    
    # Get rid of the ".csv" part to get the table name
    table_name="${filename%.csv}"

    echo "Moving process started"

    # Copy the CSV file into the postgres container's /tmp folder
    docker cp "$csv_file" "$CONTAINER_NAME":/tmp/"$filename"

    # Run \COPY from inside the container
    docker exec -u postgres "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "\COPY $table_name FROM '/tmp/$filename' WITH (FORMAT csv, HEADER true)"

    echo "Table $table_name got loaded successfully"
done