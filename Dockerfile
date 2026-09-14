FROM node:20-slim

# Install system dependencies & Litestream
RUN apt-get update && apt-get install -y python3 make g++ wget ca-certificates && rm -rf /var/lib/apt-lists/*
RUN wget https://github.com/benbjohnson/litestream/releases/download/v0.3.13/litestream-v0.3.13-linux-amd64.tar.gz -O - | tar -xz -C /usr/local/bin

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN mkdir -p /app/data

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["litestream", "replicate", "-exec", "node server.js", "-config", "/app/litestream.yml"]
