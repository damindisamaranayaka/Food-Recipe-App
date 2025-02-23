# Use Node.js base image
FROM node:18-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the files
COPY . .

# Expose Vite's default port
EXPOSE 5173

# Start the development server
CMD ["npm", "run", "dev", "--", "--host"]
