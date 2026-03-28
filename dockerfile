FROM node:22-alpine
WORKDIR /app
RUN npm install -g @openclaw/cli
EXPOSE 18789
CMD ["openclaw", "gateway", "start", "--host", "0.0.0.0"]
