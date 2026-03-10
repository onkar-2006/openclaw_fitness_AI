FROM node:22-bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    git \
    && npm install -g openclaw@latest \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy project files
COPY . .

# Environment setup
ENV OPENCLAW_WORKSPACE_DIR=/app
# Render provides the $PORT variable automatically, 
# but we'll default it to 10000 which Render likes.
ENV PORT=10000
ENV OPENCLAW_GATEWAY_PORT=10000
ENV OPENCLAW_GATEWAY_BIND=0.0.0.0

EXPOSE 10000

# Remove '--foreground' as it's now the default in 2026 gateway start
# We use 'npx' to ensure we call the local binary if global fails
CMD ["npx", "openclaw", "gateway", "start", "--allow-unconfigured"]