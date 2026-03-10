FROM node:22-bookworm-slim

# Install only the absolute basics
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# CRITICAL: We use --no-optional to skip the heavy local AI compilation
RUN npm install -g openclaw@latest --no-optional

# Keep memory very tight for the 512MB limit
ENV NODE_OPTIONS="--max-old-space-size=350"
ENV OPENCLAW_TELEMETRY=false
# Disable the "Brain" and "Vision" to save RAM
ENV OPENCLAW_PLUGINS_DISABLE="web-search,vision,browser,history-sync,local-ai"

ENTRYPOINT ["npx", "openclaw", "gateway", "run"]
CMD ["--allow-unconfigured", "--port", "18789", "--bind", "auto"]