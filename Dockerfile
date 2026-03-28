# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl sudo build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash openclaw
USER openclaw
WORKDIR /home/openclaw

# Download and run OpenClaw installer with verbose output
RUN curl -fsSL https://openclaw.ai/install.sh -o install.sh && \
    chmod +x install.sh && \
    bash -x ./install.sh

# Expose OpenClaw port
EXPOSE 18789

# Start OpenClaw gateway
CMD ["/home/openclaw/.local/bin/openclaw", "gateway", "start", "--host", "0.0.0.0"]
