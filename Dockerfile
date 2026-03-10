FROM node:22-alpine

# Install essential system tools
RUN apk add --no-cache python3 py3-pip curl git

WORKDIR /app
COPY . .

# Install OpenClaw globally
RUN npm install -g openclaw@latest

# Aggressive memory management for the 512MB limit
ENV NODE_OPTIONS="--max-old-space-size=380"
ENV OPENCLAW_TELEMETRY=false
ENV OPENCLAW_PLUGINS_DISABLE="web-search,vision,browser,history-sync"
ENV OPENCLAW_STORAGE_TYPE=disk

# Use npx to find the executable automatically
ENTRYPOINT ["npx", "openclaw", "gateway", "run"]
CMD ["--allow-unconfigured", "--port", "18789", "--bind", "auto"]