# Use official Node.js 22 image
FROM node:22-alpine

# Set working directory
WORKDIR /app

# Install OpenClaw CLI globally
RUN npm install -g @openclaw/cli

# Expose the default OpenClaw port
EXPOSE 18789

# Start the OpenClaw gateway
CMD ["openclaw", "gateway", "start", "--host", "0.0.0.0"]
