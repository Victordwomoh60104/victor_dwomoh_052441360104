 #!/bin/bash

LOGFILE="$HOME/myproject/logs/update.log"
EMAIL="godfredeshun295@example.com"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Ensure log file exists
mkdir -p "$(dirname "$LOGFILE")"
echo "=== Update succeeded at $DATE ===" > "$LOGFILE"

# Update packages
if sudo apt update -y 2>&1 | tee -a "$LOGFILE"; then
	echo "apt update succeeded." | tee -a "$LOGFILE"
else
	echo "apt udate failed!" | tee -a "$LOGFILE"
	mail -s "System Update Failure" "$EMAIL" < "$LOGFILE"
	exit 1
fi


# Upgrade packages
if sudo apt upgrade -y 2>&1 | tee -a "$LOGFILE"; then
	echo "apt upgrade succeeded." | tee -a "$LOGFILE"
	mail -s "System Update Success" "$EMAIL" < "$LOGFILE"
else
	echo "apt upgrade failed!" | tee -a "$LOGFILE"
	mail -s "System Update Failure" "$EMAIL" < "$LOGFILE"
	exit 1
fi


echo "=== Update finished at $(date '+%Y-%m-%d %H:%M:%S') ===" | tee -a "$LOGFILE"
