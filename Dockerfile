FROM node:22-bookworm-slim


RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    git \
    && npm install -g openclaw@latest \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .


ENV PORT=18789
ENV OPENCLAW_WORKSPACE_DIR=/app

EXPOSE 18789


CMD ["npx", "openclaw", "gateway", "run", "--allow-unconfigured", "--port", "18789"]