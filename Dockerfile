# 1. BUILD PHASE -  note that in here we don't use the same strucutre used in the Dockerfile.dev file because we are in the Production Phase and we don't need to change the code to see the changes automatically

# Create base image from node:apline version 16 in the build phase
FROM node:16-alpine as builder

# Create current working directory 'app' inside the container
WORKDIR '/app'

# Copy package.json file from the root of our project (frontend) to the root of the current working directory 'app'
COPY package.json .

# Install dependencies inside the container
RUN npm install

# Copy all files and folder from the root of our project (frontend) to the root of the current working directory 'app'
COPY . .

# Run npm build to create 'buidl' folder
RUN npm run build


# 2. RUN PHASE
FROM nginx

# Expose port 80
EXPOSE 80

# Copy 'build' folder from the Build Phase to the Nginx container - this will start automatically Nginx
COPY --from=builder /app/build /usr/share/nginx/html 