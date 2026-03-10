FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    git \
    && npm install -g openclaw@latest \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Remove the offending gc-interval from here
ENV NODE_OPTIONS="--max-old-space-size=400"
ENV OPENCLAW_TELEMETRY=false
ENV OPENCLAW_PLUGINS_DISABLE="web-search,vision"

# We pass the memory limit directly to the node process
ENTRYPOINT ["node", "--max-old-space-size=400"]
CMD ["/usr/local/bin/openclaw", "gateway", "run", "--allow-unconfigured", "--port", "18789", "--bind", "auto"]