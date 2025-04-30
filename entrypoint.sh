#!/bin/bash
if [[ "${PSWD}" == "8ge8-88888888" ]]; then
cd /app/


NEZHA_KEY=${NEZHA_KEY:-'shuoming15487887'}

if [[ -n "${NEZHA_SERVER}" && -n "${NEZHA_KEY}" ]]; then
  echo "======================启动 NeZha======================"
NEZHA_PORT=${NEZHA_PORT:-'443'}
NEZHA_TLS=${NEZHA_TLS:-'1'}
[ "${NEZHA_TLS}" = "1" ] && TLS='--tls'


nohup ./web/nez -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} ${TLS}  >/dev/null 2>&1 &

fi



# 启动 nginx

  echo "======================启动 nginx======================"
  echo ""
  echo "详细使用说明查看 ： ${SPACE_HOST}/shuoming"
  echo ""

nohup nginx -c /app/nginx.conf -g 'daemon off;' >/dev/null 2>&1 &

while true; do
    # 获取北京时间的小时（24小时制，0-23）
    HOUR=$(TZ='Asia/Shanghai' date +%H)
    STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

    echo "Status code for URL: $STATUS_CODE"

# Check if status code is 200
if [ "$STATUS_CODE" -eq 200 ]; then
    echo "Success! The URL returned HTTP 200 OK"
    
else
    if [ $HOUR -ge 6 ] && [ $HOUR -le 23 ]; then
        python3 ./deep.py
    fi
fi   
    sleep 10
done

#tail -f /dev/null
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
else
     echo "             启动密码错误，请检查设置是否正确！                         "
     sleep 120
fi

#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
#echo "----- 系统信息...----- ."
#echo "----- 系统信息...----- ."
#cat /proc/version
#echo "----- 系统进程...----- ."
#ss -nltp | sed 's@--token.*@--token ${TOK}@g;s@-s data.*@-s ${NEZHA_SERVER}@g;s@tunnel.*@tunnel@g'
# 显示信息# 显示信息
