FROM eclipse-temurin:17-jre-alpine

# Cài đặt Xvfb (màn hình ảo), font chữ cho AWT và python3 để giữ Port cho Render
RUN apk add --no-cache xvfb font-noto python3

WORKDIR /app

# Copy file giả lập và file game vào container
COPY ZMicroPro.jar ZMicroPro.jar
COPY app.jar app.jar

# Chạy Python Web Server giả mở PORT + Chạy MicroEmu qua màn hình ảo Xvfb
CMD python3 -m http.server ${PORT:-10000} & xvfb-run -a java -jar ZMicroPro.jar app.jar
