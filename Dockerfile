# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including Node.js 22 FIRST
RUN apt-get update && \
    apt-get install -y curl sudo build-essential && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user and give it sudo access (temporarily)
RUN useradd -m -s /bin/bash openclaw && \
    echo "openclaw ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the openclaw user
USER openclaw
WORKDIR /home/openclaw

# Run OpenClaw installer (it will detect Node.js and skip sudo steps)
RUN curl -fsSL https://openclaw.ai/install.sh | bash

# Expose OpenClaw port
EXPOSE 18789

# Start OpenClaw gateway
CMD ["/home/openclaw/.local/bin/openclaw", "gateway", "start", "--host", "0.0.0.0"]
