FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y curl git && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Install ONLY the gateway core
RUN npm install -g openclaw@latest --no-optional

# CRITICAL: We drop the heap even further but disable ALL extras
ENV NODE_OPTIONS="--max-old-space-size=300 --expose-gc"
ENV OPENCLAW_TELEMETRY=false
ENV OPENCLAW_PLUGINS_DISABLE="web-search,vision,browser,history-sync,local-ai,canvas,health-monitor"
ENV OPENCLAW_STORAGE_TYPE=disk

# We bypass the 'gateway run' wrapper and call the entrypoint directly if possible
# or use the most stripped down version of the command.
ENTRYPOINT ["npx", "openclaw"]
CMD ["gateway", "run", "--allow-unconfigured", "--port", "18789", "--bind", "auto"]