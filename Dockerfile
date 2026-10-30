FROM eclipse-temurin:17-jre-alpine

# Cài đặt Xvfb, font chữ và python3
RUN apk add --no-cache xvfb font-noto python3 libxrender libxtst libxi

WORKDIR /app

COPY ZMicroPro.jar ZMicroPro.jar
COPY app.jar app.jar

ENV DISPLAY=:99

# 1. Dọn dẹp file lock cũ /tmp/.X99-lock nếu có
# 2. Bật Xvfb màn hình ảo (:99)
# 3. Bật Python Web Server giữ PORT cho Render
# 4. Đợi 2 giây rồi chạy Java MicroEmulator với tham số ép nhận AWT
CMD rm -f /tmp/.X99-lock && \
    Xvfb :99 -screen 0 1024x768x16 -ac & \
    python3 -m http.server ${PORT:-10000} & \
    sleep 2 && \
    java -Djava.awt.headless=false -jar ZMicroPro.jar app.jar
