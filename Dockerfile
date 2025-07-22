# Use a Node.js official image as the base image.
# We choose a specific version (e.g., 20) and often a slim variant for smaller image size.
FROM node:24-slim

# Set the working directory inside the container.
# All subsequent commands will be executed relative to this directory.
WORKDIR /app

# Copy package.json and package-lock.json first.
# This allows Docker to cache the npm install step if these files don't change,
# speeding up subsequent builds.
COPY package*.json ./

# Install project dependencies.
# The `npm ci` command is preferred for continuous integration/production builds
# as it installs dependencies strictly from package-lock.json.
RUN npm ci

# Copy the rest of your application code to the working directory.
# This includes your src folder.
COPY . .

# Build your TypeScript code into JavaScript.
# This command runs `tsc` to compile your TypeScript.
# The compiled JavaScript will be in the `dist` directory (as per tsconfig.json).
RUN npm run build

# Expose the port your Express app will listen on.
# This informs Docker that the container listens on this port at runtime.
# It does NOT publish the port; that's done with `docker run -p`.
EXPOSE 3000

# Define the command to run when the container starts.
# This will execute the compiled JavaScript application.
# `npm start` runs `node dist/index.js` as defined in your package.json.
CMD [ "npm", "start" ]