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
  log_message "启动 NeZha..."
  NEZHA_PORT=${NEZHA_PORT:-'443'}
  NEZHA_TLS=${NEZHA_TLS:-'1'}
  TLS_FLAG=""
  [[ "${NEZHA_TLS}" = "1" ]] && TLS_FLAG="--tls"
  
  nohup ./web/nez -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} ${TLS_FLAG} >/dev/null 2>&1 &
  
  # Wait a moment to ensure process started
  sleep 2
  if is_process_running "./web/nez"; then
    log_message "NeZha 成功启动"
  else
    log_message "NeZha 启动失败，请检查配置"
  fi
}

# Function to ensure NeZha is running
ensure_nezha_running() {
  if [[ -n "${NEZHA_SERVER}" && -n "${NEZHA_KEY}" ]]; then
    if ! is_process_running "./web/nez"; then
      log_message "NeZha 进程不存在，正在重新启动..."
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
  log_message "下载 Cookies 文件..."
  if curl -s -L -o /app/deepnote_cookies.json "${COOK_URL}"; then
    log_message "Cookies 文件下载成功: /app/deepnote_cookies.json"
  else
    log_message "Cookies 文件下载失败，请检查 COOK_URL 是否正确"
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
  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

  if [ "$STATUS_CODE" -eq 200 ]; then
    log_message "Success! The URL returned HTTP 200 OK"
  else
    log_message "Status code for URL: $STATUS_CODE"
    if [ $HOUR -ge 6 ] && [ $HOUR -le 23 ]; then
      log_message "Running deep.py..."
      python3 ./deep.py
    else
      log_message "Not at runtime!"
    fi
  fi
  if [[ -n "${URL2}" ]]; then
    STATUS_CODE2=$(curl -s -o /dev/null -w "%{http_code}" "$URL2")

  if [ "$STATUS_CODE2" -eq 200 ]; then
    log_message "Success! The URL returned HTTP 200 OK"
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
  sleep 5
done
