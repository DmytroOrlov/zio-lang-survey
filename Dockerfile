# docker build .
FROM oracle/graalvm-ce:19.2.0 as builder

WORKDIR /app
COPY . /app

RUN gu install native-image

RUN ./sbt graalvm-native-image:packageBin

FROM alpine:3.10.2

COPY --from=builder /app/target/graalvm-native-image/app /app

CMD ["/app", "-web"]
