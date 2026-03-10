FROM node:22-bookworm-slim

# Install Python and OpenClaw
RUN apt-get update && apt-get install -y python3 curl && \
    npm install -g openclaw@latest && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy everything from your repo to the container
COPY . .

# Set Workspace and Port
ENV OPENCLAW_WORKSPACE_DIR=/app
# Render will tell us which port to use via the PORT env var
ENV OPENCLAW_GATEWAY_PORT=18789 

EXPOSE 18789

# Start command
CMD ["openclaw", "gateway", "start", "--foreground", "--allow-unconfigured"]