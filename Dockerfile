FROM rust:1-slim as builder
WORKDIR /usr/src/dng-server
RUN apt-get update && apt-get install -y libssl-dev pkg-config && rm -rf /var/lib/apt/lists/*
COPY . .
RUN cargo install --path .

FROM debian:slim
COPY --from=builder /usr/local/cargo/bin/dng-server /usr/local/bin/dng-server
EXPOSE 8080
CMD ["dng-server"]
