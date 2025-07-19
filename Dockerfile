# Use the official Rust image as a builder
FROM rust:1.76 AS builder

# Set the working directory
WORKDIR /usr/src/appflowy-cloud

# Install build dependencies
RUN apt-get update && apt-get install -y protobuf-compiler

# Copy the Cargo files to cache dependencies
COPY Cargo.toml Cargo.lock ./
COPY libs ./libs

# Create a dummy main.rs to cache dependencies
RUN mkdir -p src && echo "fn main() {}" > src/main.rs

# Build dependencies to cache them
RUN cargo build --release --locked

# Copy the rest of the application source code
COPY . .

# Build the application
RUN cargo build --release --locked

# Use a smaller, Debian-based image for the final image
FROM debian:buster-slim
RUN apt-get update && apt-get install -y libssl-dev && rm -rf /var/lib/apt/lists/*

# Create a non-root user and group
RUN groupadd -r appflowy && useradd -r -g appflowy -d /data -s /sbin/nologin -c "appflowy user" appflowy

# Create and set permissions for the data directory
RUN mkdir -p /data && chown -R appflowy:appflowy /data
VOLUME /data

# Set the working directory
WORKDIR /usr/local/bin

# Copy the compiled binary from the builder stage
COPY --from=builder /usr/src/appflowy-cloud/target/release/appflowy_cloud .

# Set ownership of the binary
RUN chown appflowy:appflowy appflowy_cloud

# Switch to the non-root user
USER appflowy

# Expose the application port
EXPOSE 8000

# Set the command to run the application
CMD ["./appflowy_cloud"]
