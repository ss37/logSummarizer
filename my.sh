#!/bin/bash
# This is a basic bash script 
# It reads the contents of the recent-most log file
# Generates a list of statements at ERROR and SEVERE levels of logs
# Outputs them in a file

# get the filename
file="$HOME/logs/catalina.$(date +"%Y-%m-%d")"

# check if the file exists in the expected path
if [ ! -f "$file" ];
then
     echo "No log found! Expected log file 'catalina.$(date +"%Y-%m-%d")' in directory $HOME/logs."
fi

# check for lines of SEVERE logs
severe_logs=$(grep SEVERE $file | sed 's/SEVERE/\\nSEVERE/')
severe_logs_count=$(grep SEVERE $file | wc -l)

# check for lines of ERROR logs
error_logs=$(grep ERROR $file | sed 's/ERROR/\\nERROR/')
error_logs_count=$(grep ERROR $file | wc -l)

# Create a summary and add it to a
# new backup file in the current directory
summary="$severe_logs_count severe logs found on $(date +"%Y-%m-%d") are as follows:\n"
summary=$summary$severe_logs
summary=$summary"\n\n\n$error_logs_count error logs found on $(date +"%Y-%m-%d") are as follows:\n"
summary=$summary$error_logs

echo -e $summary > summary_$(date +"%Y-%m-%d").txt

echo "Summary has been saved in file $pwd/summary_$(date +"%Y-%m-%d").txt"
