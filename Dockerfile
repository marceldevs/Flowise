# Build local monorepo image
# docker build --no-cache -t  flowise .

# Run image
# docker run -d -p 3000:3000 flowise

FROM node:20-alpine

# Install system dependencies and build tools
RUN apk update && \
    apk add --no-cache \
        libc6-compat \
        python3 \
        make \
        g++ \
        build-base \
        cairo-dev \
        pango-dev \
        chromium \
        curl && \
    npm install -g pnpm

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

ENV NODE_OPTIONS=--max-old-space-size=8192

WORKDIR /usr/src/app

# Copy files AND set permission in one step
COPY --chown=node:node . .

# Now you can safely switch user
USER node
