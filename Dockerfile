FROM eclipse-temurin:17-jre

# Cài đặt màn hình ảo xvfb và python3
RUN apt-get update && apt-get install -y xvfb python3

WORKDIR /app
COPY . .

ENV DISPLAY=:99

# Mở màn hình ảo + Web server + Chạy game
CMD Xvfb :99 & python3 -m http.server $PORT & sleep 1 && java -Djava.awt.headless=false -jar ZMicroPro.jar app.jar
