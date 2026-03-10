FROM node:22-bookworm-slim

# Add git to the install list so npm can fetch OpenClaw dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    git \
    && npm install -g openclaw@latest \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy all files
COPY . .

# Environment setup
ENV OPENCLAW_WORKSPACE_DIR=/app
ENV OPENCLAW_GATEWAY_PORT=18789
ENV OPENCLAW_GATEWAY_BIND=0.0.0.0
ENV NODE_ENV=production

EXPOSE 18789

# Start Gateway
CMD ["openclaw", "gateway", "start", "--foreground", "--allow-unconfigured"] 