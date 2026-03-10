# Alpine is the lightest possible Linux for Docker
FROM node:22-alpine

# Install only essential tools
RUN apk add --no-cache python3 py3-pip curl git

WORKDIR /app
COPY . .

# Force Node to be extremely aggressive with memory
ENV NODE_OPTIONS="--max-old-space-size=350"
# DISABLE memory-heavy features
ENV OPENCLAW_TELEMETRY=false
ENV OPENCLAW_PLUGINS_DISABLE="web-search,vision,browser,history-sync"
ENV OPENCLAW_STORAGE_TYPE=disk

# Use a direct path to the binary to save execution overhead
ENTRYPOINT ["node", "--max-old-space-size=350"]
CMD ["/usr/local/bin/openclaw", "gateway", "run", "--allow-unconfigured", "--port", "18789", "--bind", "auto"]