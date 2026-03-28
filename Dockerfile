FROM ghcr.io/openclaw/openclaw:latest

# Switch to root to ensure write access
USER root

# Create writable config directory
RUN mkdir -p /home/node/.openclaw && \
    chown -R node:node /home/node/.openclaw

# Create a start script
RUN echo '#!/bin/sh\n\
export GATEWAY_HOST=0.0.0.0\n\
export HOST=0.0.0.0\n\
exec openclaw gateway run --allow-unconfigured' > /start.sh && \
    chmod +x /start.sh

# Switch back to node user
USER node

# Copy config
COPY openclaw.yaml /home/node/.openclaw/config.yaml

# Expose port
EXPOSE 18789

# Run start script
CMD ["/start.sh"]
