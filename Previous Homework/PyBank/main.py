#dependencies
import os
import csv

#File to load
budget_path = os.path.join("Resources","budget_data.csv")

#File to output
file_to_output = os.path.join("analysis", "budget_analysis.txt")

#Track financial parameters for calculation
total_months = 0
months_of_change=[]
net_change_list=[]
greatest_increase=["", 0]
greatest_decrease=["",99999999999]
total_net = 0

#read the csv and convert to list of dictionaries
with open(budget_path) as financial_data:
    reader = csv.reader(financial_data)

    #Read the header row
    header = next(reader)
    #Extract first row to avoid appending to net_change_list
    first_row = next(reader)
    total_months = total_months + 1
    total_net = total_net + int(first_row[1])
    prev_net = int(first_row[1])

    for row in reader:
        #track the total
        total_months = total_months + 1
        total_net = total_net + int(row[1])
      
        #track the net change
        net_change = int(row[1]) - prev_net
        prev_net = int(row[1])
        net_change_list = net_change_list + [net_change]
        months_of_change = months_of_change + [row[0]]
        
        #Calculate the greatest increase
        if net_change > greatest_increase[1]:
            greatest_increase[0] = row[0]
            greatest_increase[1] = net_change

        #Calculate the greatest decrease
        if net_change < greatest_decrease [1]:
            greatest_decrease[0] = row [0]
            greatest_decrease[1] = net_change 
        # Calculate the average net change
            net_monthly_avg = sum(net_change_list) / len(net_change_list)
    
    print("Financial Analysis")
    print("---------------------------")
    print(f"Total Months: {str(total_months)}") 
    print(f"Total: {str(total_net)}")
    print(f"Average change: {str(net_monthly_avg)}")
    print(f"Greatest Increase: {str(greatest_increase)}")
    print(f"Greated Decrease: {str(greatest_decrease)}")  



    
 



