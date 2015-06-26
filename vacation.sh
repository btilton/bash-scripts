#!/bin/bash
#################
# Author: Brian Tilton
# Date  : 2015-06-26
# Title : vacation.sh
# Desc  : Script to reactivate A Google Apps account and then
#       :   set a 50 year away message using GAM
#################

# Change this to location of your gam.py
gam="python $HOME/gam/gam.py"

# Print usage
if [ -z "$*" ]; then
    echo 'usage: vacation.sh user_email_address'
    exit 0
fi

start_date=`date +%Y-%m-%d` #Start date for vataion message in correct format

end_date=`date -v+50y +%Y-%m-%d` #End date for vacation message. 50 years from now

$gam update user $1 suspended off &&

$gam user $1 vacation on subject "Thank you for your message" message "Thank you for your message. This is an unmonitored email account. Please reach out to khippler@upwork.com with any requests. Thank you." startdate $start_date enddate $end_date &&

$gam user $1 show vacation
