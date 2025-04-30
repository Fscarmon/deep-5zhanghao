# 选项 1: Python 3.11 slim 版本 (较小但兼容性好)
FROM python:3.11-slim

# 设置环境变量
ENV PORT=7860
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PLAYWRIGHT_BROWSERS_PATH=/app/ms-playwright

# 暴露指定端口
EXPOSE ${PORT}

# 设置工作目录
WORKDIR /app

# 复制必要文件
COPY entrypoint.sh nginx.conf /app/
COPY web/ /app/web/
COPY deep.py /app/
COPY deepnote_cookies.json /app/

# 安装系统依赖和 Playwright 与 Firefox
RUN apt-get update && \
    apt-get install -y \
    nginx \
    # Playwright 依赖
    libx11-6 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    libglib2.0-0 \
    libnss3 \
    libcups2 \
    libdbus-1-3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libasound2 && \
    pip3 install playwright pytz pyyaml && \
    playwright install --with-deps firefox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod a+x /app/entrypoint.sh /app/web/nez

# 运行脚本
CMD ["/app/entrypoint.sh"]
