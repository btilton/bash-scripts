#!/bin/bash
#################
# Author: Brian Tilton
# Date  : 2015-06-26
# Title : autorespond.sh
# Desc  : Script to reactivate A Google Apps account and then
#       :   set a 50 year away message using GAM
#################

# Change this to location of your gam.py
gam="python $HOME/gam/gam.py"

# Print usage
if [ -z "$*" ]; then
    echo 'usage: vacation.sh [user_email_address] [subject] [message]'
    exit 0
fi

# Set input variables
user=$1
subject=$2
message=$3

start_date=`date +%Y-%m-%d` #Start date for vacation message in correct format

end_date=`date -v+50y +%Y-%m-%d` #End date for vacation message. 50 years from now

$gam update user $1 suspended off &&

$gam user $user vacation on subject "$subject" message "$message" startdate $start_date enddate $end_date &&

$gam user $user show vacation
