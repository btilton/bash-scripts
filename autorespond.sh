#!/bin/bash
#################
# Author: Brian Tilton
# Date  : 2015-06-26
# Title : autorespond.sh
# Desc  : Script to reactivate A Google Apps account and then
#       :   set a 50 year away message using GAM
#################

# Set Date Variables
start_date=`date +%Y-%m-%d` #Start date for vacation message in correct format
end_date=`date -v+50y +%Y-%m-%d` #End date for vacation message. 50 years from now

usermail=''

#print usage function
function usage {
  echo "Usage: autorespond.sh [-s subject] [-m message] [user_email_address]"
  echo "       autorespond.sh [-h]"
  exit 1
}

#Default subject and message variable contents
subject="Thank you for your message"
message="Thank you for your email. The owner of this email address no longer works for Upwork."

##### MAIN

while getopts 's:m:h' flag; do
  case ${flag} in
    s ) subject="${OPTARG}" ;;
    m ) message="${OPTARG}" ;;
    h ) usage ;;
    * ) error "Unexpected option ${flag}"
        usage
        ;;
  esac
done

usermail=$1
if [$usermail = '']; then
  usage
fi

#Check if user exists
userexists=`$gam user info $usermail | sed -n 1p | awk '{print $1;}' | cut -d: -f 1`

if [[ $userexists == Error ]]; then
  echo "User does not exist in Google Apps"
  exit 1
fi

if [[ $userexists == User ]]; then
  $gam update user $usermail suspended off &&

  $gam user $usermail vacation on subject "$subject" message "$message" startdate $start_date enddate $end_date &&

  $gam user $usermail show vacation
fi
