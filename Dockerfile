FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    git \
    && npm install -g openclaw@latest \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# CRITICAL: Force Node to stay under 400MB and cleanup constantly
ENV NODE_OPTIONS="--max-old-space-size=400 --gc-interval=50"
# Disable memory-heavy features we don't need for the demo
ENV OPENCLAW_TELEMETRY=false
ENV OPENCLAW_PLUGINS_DISABLE="web-search,vision"

ENTRYPOINT ["node", "--max-old-space-size=400", "/usr/local/bin/openclaw", "gateway", "run"]
CMD ["--allow-unconfigured", "--port", "18789", "--bind", "auto"]