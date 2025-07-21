#!/bin/bash

mkdir -p 2023-02-16-access-logs

start_time=$(date -d "2023-02-16 21:26:00" +%s)

for i in 212500 212600 212700 212800; do
  log_file="2023-02-16-access-logs/${i}-access.log"
  > "$log_file"

  for j in {1..1000}; do
    # timestamp dalam range 10 menit
    random_offset=$((RANDOM % 600))
    log_time=$(date -d "@$((start_time + random_offset))" "+%d/%b/%Y:%H:%M:%S")

    # 70% kemungkinan HTTP 500
    status=$((RANDOM % 10 < 7 ? 500 : 200))

    echo "123.123.123.123 - - [16/Feb/2023:$log_time +0700] \"GET /test HTTP/1.1\" $status 1234 \"-\" \"Curl/7.64.1\"" >> "$log_file"
  done
done
