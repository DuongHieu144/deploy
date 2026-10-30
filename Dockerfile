FROM eclipse-temurin:17-jre

# Bổ sung các thư viện X11 bắt buộc cho Java AWT: libxtst6 libxrender1 libxi6
RUN apt-get update && apt-get install -y xvfb python3 libxtst6 libxrender1 libxi6

WORKDIR /app
COPY . .

ENV DISPLAY=:99

# Xóa file lock cũ (tránh lỗi display 99) + Mở màn ảo + Web server + Chạy game
CMD rm -f /tmp/.X99-lock && Xvfb :99 -ac & python3 -m http.server $PORT & sleep 2 && java -Djava.awt.headless=false -jar ZMicroPro.jar app.jar
