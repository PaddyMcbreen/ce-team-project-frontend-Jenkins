# Stage 1: Build the Node.js application
FROM node:20.10.0 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Create the production environment with Nginx
FROM nginx:1.21.0-alpine AS production

# Copy the built source code from the first stage to the Nginx directory
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
ENV VITE_API_BASE_URL=http://a62a4064d67034b2e86c834e98710ac9-b26e60e44764b904.elb.eu-west-2.amazonaws.com
# Expose the port that Nginx will listen on 
EXPOSE 80

# Define the command to start Nginx
CMD ["nginx", "-g", "daemon off;"]