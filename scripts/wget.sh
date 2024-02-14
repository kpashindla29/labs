#!/bin/sh

#
# Generated on Wed Feb 14 08:48:10 PST 2024
# Start of user configurable variables
#
LANG=C
export LANG

#Trap to cleanup cookie file in case of unexpected exits.
trap 'rm -f $COOKIE_FILE; exit 1' 1 2 3 6 

# SSO username 
printf 'SSO User Name:' 
read SSO_USERNAME

# Path to wget command
WGET=/usr/bin/wget

# Log directory and file
LOGDIR=.
LOGFILE=$LOGDIR/wgetlog-$(date +%m-%d-%y-%H:%M).log

# Print wget version info 
echo "Wget version info: 
------------------------------
$($WGET -V) 
------------------------------" > "$LOGFILE" 2>&1 

# Location of cookie file 
COOKIE_FILE=$(mktemp -t wget_sh_XXXXXX) >> "$LOGFILE" 2>&1 
if [ $? -ne 0 ] || [ -z "$COOKIE_FILE" ] 
then 
 echo "Temporary cookie file creation failed. See $LOGFILE for more details." |  tee -a "$LOGFILE" 
 exit 1 
fi 
echo "Created temporary cookie file $COOKIE_FILE" >> "$LOGFILE" 

# Output directory and file
OUTPUT_DIR=.
#
# End of user configurable variable
#

# The following command to authenticate uses HTTPS. This will work only if the wget in the environment
# where this script will be executed was compiled with OpenSSL.
# 
 $WGET  --secure-protocol=auto --save-cookies="$COOKIE_FILE" --keep-session-cookies --http-user "$SSO_USERNAME" --ask-password  "https://edelivery.oracle.com/osdc/cliauth" -a "$LOGFILE"

# Verify if authentication is successful 
if [ $? -ne 0 ] 
then 
 echo "Authentication failed with the given credentials." | tee -a "$LOGFILE"
 echo "Please check logfile: $LOGFILE for more details." 
else
 echo "Authentication is successful. Proceeding with downloads..." >> "$LOGFILE" 
 $WGET  --load-cookies="$COOKIE_FILE" --save-cookies="$COOKIE_FILE" --keep-session-cookies "https://edelivery.oracle.com/osdc/softwareDownload?fileName=V38500-01_1of2.zip&token=ek1MYlhHUU8zQ0Y4bSszZHZGK0VwQSE6OiFmaWxlSWQ9NjI0MjM3MzcmZmlsZVNldENpZD03ODQ4MTYmcmVsZWFzZUNpZHM9NzY0NTMmcGxhdGZvcm1DaWRzPTM1JmRvd25sb2FkVHlwZT05NTc2NCZhZ3JlZW1lbnRJZD0xMDQ4OTEzMCZlbWFpbEFkZHJlc3M9a2lzaG9yZS5wYXNoaW5kbGFAZ21haWwuY29tJnVzZXJOYW1lPUVQRC1LSVNIT1JFLlBBU0hJTkRMQUBHTUFJTC5DT00maXBBZGRyZXNzPTE4NS4zOC4xMTUuMTYyJnVzZXJBZ2VudD1Nb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTIxLjAuMC4wIFNhZmFyaS81MzcuMzYmY291bnRyeUNvZGU9R0ImZGxwQ2lkcz03ODU5MTM" -O "$OUTPUT_DIR/V38500-01_1of2.zip" >> "$LOGFILE" 2>&1 
 $WGET --load-cookies="$COOKIE_FILE" "https://edelivery.oracle.com/osdc/softwareDownload?fileName=V38500-01_2of2.zip&token=WGZGbHMzMndSbFBXZ1FEQzM0WHJBUSE6OiFmaWxlSWQ9NjI0MjM3MzgmZmlsZVNldENpZD03ODQ4MTYmcmVsZWFzZUNpZHM9NzY0NTMmcGxhdGZvcm1DaWRzPTM1JmRvd25sb2FkVHlwZT05NTc2NCZhZ3JlZW1lbnRJZD0xMDQ4OTEzMCZlbWFpbEFkZHJlc3M9a2lzaG9yZS5wYXNoaW5kbGFAZ21haWwuY29tJnVzZXJOYW1lPUVQRC1LSVNIT1JFLlBBU0hJTkRMQUBHTUFJTC5DT00maXBBZGRyZXNzPTE4NS4zOC4xMTUuMTYyJnVzZXJBZ2VudD1Nb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTIxLjAuMC4wIFNhZmFyaS81MzcuMzYmY291bnRyeUNvZGU9R0ImZGxwQ2lkcz03ODU5MTM" -O "$OUTPUT_DIR/V38500-01_2of2.zip" >> "$LOGFILE" 2>&1 
fi 

# Cleanup
rm -f "$COOKIE_FILE" 
echo "Removed temporary cookie file $COOKIE_FILE" >> "$LOGFILE" 

