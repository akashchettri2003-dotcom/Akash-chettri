FROM node:20-slim

# Install compilation tools required for better-sqlite3 native binaries
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt-lists/*

WORKDIR /app

# Install production dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy application code
COPY . .

# Ensure persistent database directory exists
RUN mkdir -p /app/data

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["node", "server.js"]
