#!/bin/bash

LOG="$HOME/tcp_monitor.log"
ALERT_EMAIL="uyenuyennguyen999@gmail.com"
THRESHOLD=10

echo "=== TCP Monitor Starting ==="
echo "Log file: $LOG"

INCOMPLETE=$(netstat -ant | grep -E "SYN_SENT|SYN_RECV|FIN_WAIT|CLOSE_WAIT" | wc -l)

echo "Incomplete connections found: $INCOMPLETE"
echo "[$(date)] Incomplete: $INCOMPLETE" >> "$LOG"

if [ "$INCOMPLETE" -gt "$THRESHOLD" ]; then
    MESSAGE="WARNING: $INCOMPLETE incomplete TCP connections detected on $(hostname)"
    echo "$MESSAGE" | mail -s "TCP Alert" "$ALERT_EMAIL"
    logger -t TCP_MONITOR "$MESSAGE"
    echo "ALERT: Threshold exceeded!"
else
    echo "Status: Normal (under threshold)"
fi

echo "Log updated: $LOG"
echo "=== TCP Monitor Finished ==="
