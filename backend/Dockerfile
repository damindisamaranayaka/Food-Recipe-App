# Use Node.js base image
FROM node:18-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install
# After the npm install line, add:
RUN npm rebuild bcrypt --update-binary


# Copy the rest of the app files
COPY . .

# Copy the environment file
COPY .env .env

# Expose the port for the backend
EXPOSE 5000

# Set environment variable (optional, but useful for debugging)
ENV NODE_ENV=development

# Run the application
CMD ["node", "server.js"]
