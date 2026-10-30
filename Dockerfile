FROM eclipse-temurin:17-jre-alpine

# Cài đặt Xvfb, font chữ và python3
RUN apk add --no-cache xvfb font-noto python3

WORKDIR /app

COPY ZMicroPro.jar ZMicroPro.jar
COPY app.jar app.jar

# Khai báo màn hình ảo màn định
ENV DISPLAY=:99

# 1. Chạy Python HTTP server giữ PORT cho Render
# 2. Khởi chạy màn hình ảo Xvfb ngầm (:99)
# 3. Đợi 1 giây cho Xvfb khởi tạo xong rồi chạy Java MicroEmulator
CMD python3 -m http.server ${PORT:-10000} & Xvfb :99 -screen 0 1024x768x16 & sleep 1 && java -jar ZMicroPro.jar app.jar
