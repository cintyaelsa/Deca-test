import os
import random
from datetime import datetime, timedelta

# Konfigurasi
output_dir = "2023-02-16-access-logs"
os.makedirs(output_dir, exist_ok=True)

status_pool = [200] * 25 + [500] * 75  # 75% HTTP 500
base_time = datetime.strptime("16/Feb/2023:21:26:00", "%d/%b/%Y:%H:%M:%S")

# Fungsi bikin log line
def generate_log_line(timestamp, status_code):
    return f'1.2.3.4 - - [{timestamp} +0700] "GET /something HTTP/1.1" {status_code} 1234 "-" "Mozilla/5.0"\n'

# Bikin 4 file log
for i, file_name in enumerate(["212500-access.log", "212600-access.log", "212700-access.log", "212800-access.log"]):
    with open(os.path.join(output_dir, file_name), "w") as f:
        for j in range(1200):  # 1200 lines per file
            offset = timedelta(seconds=random.randint(0, 600))
            log_time = (base_time + offset + timedelta(minutes=i)).strftime("%d/%b/%Y:%H:%M:%S")
            status = random.choice(status_pool)
            f.write(generate_log_line(log_time, status))

