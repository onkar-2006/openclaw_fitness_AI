FROM node:22-bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    git \
    && npm install -g openclaw@latest \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# --- CRITICAL FIX FOR MEMORY ---
# This tells Node.js to cap memory usage at 300MB, leaving room for the OS
ENV NODE_OPTIONS="--max-old-space-size=300"
# Disable heavy telemetry/monitoring that eats RAM
ENV OPENCLAW_TELEMETRY=false

ENV OPENCLAW_WORKSPACE_DIR=/app
ENV PORT=10000
ENV OPENCLAW_GATEWAY_PORT=10000
ENV OPENCLAW_GATEWAY_BIND=0.0.0.0

EXPOSE 10000

# Using direct node call to ensure flags are respected
CMD ["sh", "-c", "npx openclaw gateway run --allow-unconfigured --port ${PORT:-10000}"]