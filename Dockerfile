# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including Node.js 22
RUN apt-get update && \
    apt-get install -y curl sudo build-essential && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash openclaw
USER openclaw
WORKDIR /home/openclaw

# Install OpenClaw CLI via npm (now that Node.js is available)
RUN npm install -g @openclaw/cli

# Expose OpenClaw port
EXPOSE 18789

# Start OpenClaw gateway
CMD ["openclaw", "gateway", "start", "--host", "0.0.0.0"]
