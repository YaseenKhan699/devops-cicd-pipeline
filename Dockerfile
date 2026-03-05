# Stage 1 - Build dependencies
FROM node:18-alpine AS builder
WORKDIR /app

# Install only dependencies
COPY package*.json ./
RUN npm install --production

# Copy the rest of the app
COPY . .

# Stage 2 - Run app
FROM node:18-alpine
WORKDIR /app

# Copy only necessary files from builder
COPY --from=builder /app /app

EXPOSE 3000
CMD ["node", "src/index.js"]
