<h1>Bash scripts</h1>
<h2>First bash script: etl.sh</h2>
<h3>Architecture</h3>
<img src='https://github.com/user-attachments/assets/8889b96b-57c6-40da-b0ee-130e1c96c0b5'>
This script downloads some data into the local machine, transform it, and then load the final data into its final destination for further usage.
<ul>
  <li>Defines DEST_DIR as the base folder to store raw, transformed, and gold data.</li>
  <li>Stores the data URL link in an environment variable called CSV_URL.</li>
  <li>Uses basename to extract the file name from the CSV_URL environment variable.</li>
  <li>Downloads the CSV using curl into the raw subfolder, Then check if the download process gets succeeded.</li>
  <li>Transforms the downloaded data by selecting specific columns (1st, 9th, 5th, and 6th) using cut command, and Renaming the Variable_code column to be variable_code using sed command.</li>
  <li>Move the transformed data into the Gold folder.</li>
</ul>

To schedule this script, we can use CRON, by using the following steps:
<ol>
  <li>Run the following command to open the crontab file:</li>



  crontab -e



  <li>Add the following expression to the crontab file:</li>

  

  0 0 * * * /path/to/script/etl.sh



  <li> Save the file</li>
</ol>

<h2>Second bash script: move.sh </h2>
This Bash script is used to move only CSV and JSON files from a source directory to a destination directory.

<h2>Third bash script: load.sh</h2>
This script loads CSV data files into a postgres database container.
<ul>
  <li>Define the local and database configuration variables such as CSV_DIR,DB_NAME.</li>
  <li>Copy each csv file from the local machine into the container's directory</li>
  <li>Load the data from the container's directory into the postgres database using COPY command</li>
</ul>

