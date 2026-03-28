# Use the official OpenClaw image
FROM ghcr.io/openclaw/openclaw:latest

# Expose the default OpenClaw port
EXPOSE 18789

# Set host and run gateway in foreground
CMD ["sh", "-c", "HOST=0.0.0.0 GATEWAY_HOST=0.0.0.0 openclaw gateway run --allow-unconfigured"]
