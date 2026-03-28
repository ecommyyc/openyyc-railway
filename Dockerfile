FROM ghcr.io/openclaw/openclaw:latest

# Ensure config directory exists and is writable
USER root
RUN mkdir -p /home/node/.openclaw && \
    chown -R node:node /home/node/.openclaw
USER node

# Copy config
COPY openclaw.yaml /home/node/.openclaw/config.yaml

# Expose port
EXPOSE 18789

# Run gateway
CMD ["openclaw", "gateway", "run", "--allow-unconfigured"]
