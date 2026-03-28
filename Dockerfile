# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js 22 + curl
RUN apt-get update && \
    apt-get install -y curl sudo build-essential && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create openclaw user with sudo access
RUN useradd -m -s /bin/bash openclaw && \
    echo "openclaw ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to openclaw user
USER openclaw
WORKDIR /home/openclaw

# Run OpenClaw installer
RUN curl -fsSL https://openclaw.ai/install.sh | bash

# Expose port
EXPOSE 18789

# Start gateway
CMD ["/home/openclaw/.local/bin/openclaw", "gateway", "start", "--host", "0.0.0.0"]
