#!/bin/bash

# SRC_DIR refers the source folder that contains all the required data
SRC_DIR='/mnt/g/MAIN_syllybus/courses/cde_assignments/assig_2/scripts/sec_bash_script/data'

# DEST_DIR refers to the destination where the data should be loaded 
DEST_DIR='/mnt/g/MAIN_syllybus/courses/cde_assignments/assig_2/scripts/sec_bash_script/json_and_CSV'

# we use * to include all the files with CSV and JSON extensions, 
# we used "2>/dev/null" to avoid any errors instead of showing them in the output.
mv "$SRC_DIR"/*.csv "$SRC_DIR"/*.json "$DEST_DIR" 2>/dev/null


