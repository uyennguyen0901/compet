#!/bin/bash

LOG="/var/log/tcp_monitor.log"
ALERT_EMAIL="admin@example.com"
THRESHOLD=10

INCOMPLETE=$(netstat -ant | grep -E "SYN_SENT|SYN_RECV|FIN_WAIT|CLOSE_WAIT" | wc -l)

echo "[$(date)] Incomplete: $INCOMPLETE" >> "$LOG"

if [ "$INCOMPLETE" -gt "$THRESHOLD" ]; then
    MESSAGE="WARNING: $INCOMPLETE incomplete TCP connections detected on $(hostname)"
    echo "$MESSAGE" | mail -s "TCP Alert" "$ALERT_EMAIL"
    logger -t TCP_MONITOR "$MESSAGE"
fi
