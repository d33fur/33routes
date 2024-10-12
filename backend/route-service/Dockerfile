# Стартовый образ Rust
FROM rust:1.81 AS builder

WORKDIR /usr/src/app

COPY Cargo.toml Cargo.lock .env ./

COPY src src

RUN cargo build --release

FROM rust:alpine3.20

COPY --from=builder /usr/src/app/target/release/auth_service /usr/local/bin/auth_service

EXPOSE 8001

CMD ["route_service"]
