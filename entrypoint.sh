#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to log messages with timestamp
log_message() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to check if a process is running by name
is_process_running() {
  local process_name=$1
  pgrep -f "$process_name" >/dev/null
  return $?
}

# Function to start NeZha
start_nezha() {
  log_message "启动 NIPC..."
  NEZHA_PORT=${NEZHA_PORT:-'443'}
  NEZHA_TLS=${NEZHA_TLS:-'1'}
  TLS_FLAG=""
  [[ "${NEZHA_TLS}" = "1" ]] && TLS_FLAG="--tls"
  
  nohup ./web/nez -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} ${TLS_FLAG} >/dev/null 2>&1 &
  
  # Wait a moment to ensure process started
  sleep 2
  if is_process_running "./web/nez"; then
    log_message "NIPC 成功启动"
  else
    log_message "NIPC 启动失败，请检查配置"
  fi
}

# Function to ensure NeZha is running
ensure_nezha_running() {
  if [[ -n "${NEZHA_SERVER}" && -n "${NEZHA_KEY}" ]]; then
    if ! is_process_running "./web/nez"; then
      log_message "NIPC 进程不存在，正在重新启动..."
      start_nezha
    fi
  fi
}

# Function to ensure Nginx is running
ensure_nginx_running() {
  if ! is_process_running "nginx"; then
    log_message "Nginx 进程不存在，正在重新启动..."
    nohup nginx -c /app/nginx.conf -g 'daemon off;' >/dev/null 2>&1 &
    sleep 2
    if is_process_running "nginx"; then
      log_message "Nginx 成功重启"
    else
      log_message "Nginx 重启失败，请检查配置"
    fi
  fi
}

# Function to check if it's time to run idx.py based on Beijing time
should_run_idx_scheduled() {
  # Get Beijing time hour and minute
  HOUR=$(TZ='Asia/Shanghai' date +%H)
  MINUTE=$(TZ='Asia/Shanghai' date +%M)
  
  # Run at exact hours: 0, 6, 8, 10, 12, 14, 16, 18, 20, 22
  # We check if minute is 0 to run exactly at the hour
  if [[ "$MINUTE" == "00" && ("$HOUR" == "00" || "$HOUR" == "06" || "$HOUR" == "08" || "$HOUR" == "10" || 
                             "$HOUR" == "12" || "$HOUR" == "14" || "$HOUR" == "16" || 
                             "$HOUR" == "18" || "$HOUR" == "20" || "$HOUR" == "22") ]]; then
    return 0  # True in bash
  else
    return 1  # False in bash
  fi
}

# Main execution starts here
if [[ "${PSWD}" != "8ge8-88888888" ]]; then
  log_message "启动密码错误，请检查设置是否正确！"
  sleep 120
  exit 1
fi

# Change to application directory
cd /app/

# Download cookies file from COOK_URL if available
if [[ -n "${COOK_URL}" ]]; then
  log_message "下载 deep Cookies 文件..."
  if curl -s -L -o /app/deepnote_cookies.json "${COOK_URL}"; then
    log_message "deep Cookies 文件下载成功: /app/deepnote_cookies.json"
  else
    log_message "deep Cookies 文件下载失败，请检查 COOK_URL 是否正确"
  fi
fi
if [[ -n "${IDXCOOK_URL}" ]]; then
  log_message "下载 idx Cookies 文件..."
  if curl -s -L -o /app/google_cookies.json "${IDXCOOK_URL}"; then
    log_message "idx Cookies 文件下载成功: /app/google_cookies.json"
  else
    log_message "idx Cookies 文件下载失败"
  fi
fi
# Set NeZha default key if not provided
NEZHA_KEY=${NEZHA_KEY:-'shuoming15487887'}

# Start NeZha if configured
if [[ -n "${NEZHA_SERVER}" && -n "${NEZHA_KEY}" ]]; then
  start_nezha
fi

# Start nginx
log_message "启动 nginx..."
log_message "详细使用说明查看：${SPACE_HOST}/shuoming"
nohup nginx -c /app/nginx.conf -g 'daemon off;' >/dev/null 2>&1 &

# Keep track of last check time for process monitoring
LAST_PROCESS_CHECK=$(date +%s)
# Track when idx.py was last run by scheduled time
LAST_IDX_SCHEDULED_RUN=""

# Main monitoring loop
while true; do
  # Process monitoring (check every 30 seconds)
  CURRENT_TIME=$(date +%s)
  if (( CURRENT_TIME - LAST_PROCESS_CHECK >= 30 )); then
    ensure_nezha_running
    ensure_nginx_running
    LAST_PROCESS_CHECK=$CURRENT_TIME
  fi

  # Get Beijing time hour (24-hour format, 0-23)
  HOUR=$(TZ='Asia/Shanghai' date +%H)
  CURRENT_HOUR_MINUTE=$(TZ='Asia/Shanghai' date +%H%M)
  
  # Check if it's time to run idx.py based on schedule
  if should_run_idx_scheduled; then
    # Only run if we haven't already run in this minute
    if [[ "$LAST_IDX_SCHEDULED_RUN" != "$CURRENT_HOUR_MINUTE" ]]; then
      log_message "2小时运行 idx.py"
      python3 ./idx.py
      LAST_IDX_SCHEDULED_RUN=$CURRENT_HOUR_MINUTE
    fi
  fi

  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

  if [ "$STATUS_CODE" -eq 200 ]; then
    log_message "Success! URL returned HTTP 200 OK"
  else
    log_message "Status code for URL: $STATUS_CODE"
    if [ $HOUR -ge 6 ] && [ $HOUR -le 23 ]; then
      log_message "Running deep.py..."
      python3 ./deep.py
    else
      log_message "Not at runtime!"
    fi
  fi
  sleep 10
  if [[ -n "${URL2}" ]]; then
    STATUS_CODE2=$(curl -s -o /dev/null -w "%{http_code}" "$URL2")

  if [ "$STATUS_CODE2" -eq 200 ]; then
    log_message "Success! URL2 returned HTTP 200 OK"
  else
    log_message "Status code for URL2: $STATUS_CODE2"
    if [ $HOUR -ge 6 ] && [ $HOUR -le 23 ]; then
      log_message "Running deep2.py..."
      python3 ./deep2.py
    else
      log_message "Not at runtime!"
    fi
   fi
  fi
  sleep 10
    if [[ -n "${URL3}" ]]; then
    STATUS_CODE3=$(curl -s -o /dev/null -w "%{http_code}" "$URL3")

  if [ "$STATUS_CODE3" -eq 200 ]; then
    log_message "Success! idx URL returned HTTP 200 OK"
  else
    log_message "Status code for : $STATUS_CODE3"
    if [ $HOUR -ge 6 ] && [ $HOUR -le 23 ]; then
      log_message "Running idx.py..."
      python3 ./idx.py
    else
      log_message "Not at runtime!"
    fi
   fi
  fi
  sleep 10
done