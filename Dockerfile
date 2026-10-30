FROM eclipse-temurin:17-jre

# Cài đặt Xvfb, thư viện AWT, x11vnc, noVNC, websockify và Fluxbox (quản lý cửa sổ)
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    libxtst6 libxrender1 libxi6 \
    x11vnc \
    novnc websockify \
    fluxbox \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

ENV DISPLAY=:99

# Tạo liên kết để truy cập thẳng vào trang VNC khi mở URL Render
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Tiến trình khởi chạy:
# 1. Dọn dẹp lock file cũ
# 2. Mở màn hình ảo Xvfb
# 3. Chạy Fluxbox để quản lý giao diện
# 4. Bật x11vnc kết nối màn hình ảo
# 5. Chạy Java ZMicroPro
# 6. Bật websockify (noVNC) làm tiến trình chính nhận PORT của Render
CMD rm -f /tmp/.X99-lock && \
    Xvfb :99 -screen 0 1024x768x16 -ac & \
    sleep 1 && \
    fluxbox & \
    x11vnc -display :99 -forever -shared -nopw -rfbport 5900 & \
    sleep 1 && \
    java -Djava.awt.headless=false -jar ZMicroPro.jar app.jar & \
    websockify --web=/usr/share/novnc ${PORT:-10000} localhost:5900
