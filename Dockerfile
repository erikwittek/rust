FROM rust:1.70-bullseye as development

WORKDIR /usr/src/myapp
COPY . .

RUN rustup component add rustfmt

RUN cargo install --path .

FROM debian:bullseye-slim
LABEL Name=myapp Version=0.1.0

# install extra runtime dependencies
# RUN apt-get update && apt-get install -y \
#   <extra-runtime-dependencies \
#   && rm -rf /var/lib/apt/lists/*

COPY --from=development /usr/local/cargo/bin/myapp /usr/local/bin/myapp

CMD ["myapp"]
