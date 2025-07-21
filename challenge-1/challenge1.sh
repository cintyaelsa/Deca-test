#!/bin/bash

LOG_DIR="./access-logs"
NOW=$(date "+%d/%b/%Y:%H:%M:%S")
AGO=$(date -d "10 minutes ago" "+%d/%b/%Y:%H:%M:%S")

echo "Executed at $(date -d "$NOW" --iso-8601=seconds)"
echo

for FILE in "$LOG_DIR"/*.log; do
  COUNT=$(awk -v ago="$AGO" -v now="$NOW" '$0 ~ /\[.*\]/ {
    split($0, a, "[\\[\\]]");
    if (a[2] >= ago && a[2] <= now && $0 ~ / 500 /) count++
  } END { print count+0 }' "$FILE")

  echo "There were $COUNT HTTP 500 errors in ./${FILE##*/} in the last 10 minutes."
done

