#dependencies
import os
import csv

#file to load
election_path = os.path.join("Resources","election_data.csv")

#Track paramaters for calculations
total_votes = 0
total_khan = 0

#read the csv
with open(election_path) as poll_data:
    csvreader = csv.reader(poll_data)

    #read the header row
    header = next(csvreader)

    for rows in csvreader:
        total_votes = total_votes + 1

        if (row[2]=="Khan"):
            total_khan = total_khan + 1

print("Election Results")
print(f"Total Votes: {str(total_votes)}")
print(total_khan)





