# Use the official OpenClaw image
FROM ghcr.io/openclaw/openclaw:latest

# Copy config file
COPY openclaw.yaml /home/node/.openclaw/config.yaml

# Expose port
EXPOSE 18789

# Run gateway
CMD ["openclaw", "gateway", "run", "--allow-unconfigured"]
