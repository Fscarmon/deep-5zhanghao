#!/bin/bash

# Download cookies file from COOK_URL if available
if [[ -n "${COOK_URL}" ]]; then
  echo "下载 deep Cookies 文件..."
  if curl -s -L -o /app/deepnote_cookies.json "${COOK_URL}"; then
    echo "deep Cookies 文件下载成功: /app/deepnote_cookies.json"
  else
    echo "deep Cookies 文件下载失败，请检查 COOK_URL 是否正确"
  fi
fi
if [[ -n "${IDXCOOK_URL}" ]]; then
  echo "下载 idx Cookies 文件..."
  if curl -s -L -o /app/google_cookies.json "${IDXCOOK_URL}"; then
    echo "idx Cookies 文件下载成功: /app/google_cookies.json"
  else
    echo "idx Cookies 文件下载失败"
  fi
fi

if [[ -n "${URL}" ]]; then
  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

  if [ "$STATUS_CODE" -eq 200 ]; then
    echo "Success! URL returned HTTP 200 OK"
  else
    echo "Status code for URL: $STATUS_CODE"
    
      echo "Running deep.py..."
      python3 /app/deep.py
    
    fi
 fi
  
  if [[ -n "${URL2}" ]]; then
    STATUS_CODE2=$(curl -s -o /dev/null -w "%{http_code}" "$URL2")

  if [ "$STATUS_CODE2" -eq 200 ]; then
    echo "Success! URL2 returned HTTP 200 OK"
  else
    echo "Status code for URL2: $STATUS_CODE2"
    
      echo "Running deep2.py..."
      python3 /app/deep2.py
    
   fi
  fi
  
    if [[ -n "${URL3}" ]]; then
    STATUS_CODE3=$(curl -s -o /dev/null -w "%{http_code}" "$URL3")

  if [ "$STATUS_CODE3" -eq 200 ]; then
    echo "Success! idx URL returned HTTP 200 OK"
  else
    echo "Status code for : $STATUS_CODE3"
    
      echo "Running idx.py..."
      python3 /app/idx.py
    
   fi
  fi