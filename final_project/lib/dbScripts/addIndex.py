import csv

# Path to your original CSV file
input_csv_path = 'english_only_memes.csv'
# Path to the new CSV file with index
output_csv_path = 'english_only_memes_indexed.csv'

# Open the original CSV file and a new file to write to
with open(input_csv_path, mode='r', newline='', encoding='utf-8') as infile, \
     open(output_csv_path, mode='w', newline='', encoding='utf-8') as outfile:
    
    # Create CSV reader and writer
    reader = csv.reader(infile)
    writer = csv.writer(outfile)

    # Read the header from the original file and write to the new file
    header = next(reader)
    # Add the 'index' field to the header
    header.append('index')
    writer.writerow(header)

    # Add an index to each row of the CSV
    for index, row in enumerate(reader):
        # Append the index to the current row
        row.append(str(index))
        # Write the row to the new file
        writer.writerow(row)

print(f"Indexed CSV created at: {output_csv_path}")
