# Use Ubuntu as base image (better compatibility for OpenClaw)
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash openclaw
USER openclaw
WORKDIR /home/openclaw

# Install OpenClaw using official installer
RUN curl -fsSL https://openclaw.ai/install.sh | bash

# Expose OpenClaw port
EXPOSE 18789

# Start OpenClaw gateway
CMD ["/home/openclaw/.local/bin/openclaw", "gateway", "start", "--host", "0.0.0.0"]
