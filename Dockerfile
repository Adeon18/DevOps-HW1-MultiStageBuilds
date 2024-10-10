# Stage 1: Build the executable via Cmake
FROM gcc:12.2.0-bullseye as builder

RUN apt-get update && apt-get install -y cmake

WORKDIR /app

COPY CMakeLists.txt .
COPY App.cpp .

RUN cmake . && make

# Stage 2: Copy the build exe to run it
FROM debian:bullseye-slim

COPY --from=builder /app/App /usr/local/bin/App

ENTRYPOINT ["App"]
