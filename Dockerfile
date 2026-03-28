# Use pre-built OpenClaw image from Docker Hub
FROM ghcr.io/openclaw/openclaw:latest

# Expose OpenClaw port
EXPOSE 18789

# Start OpenClaw gateway
CMD ["openclaw", "gateway", "start", "--host", "0.0.0.0"]
