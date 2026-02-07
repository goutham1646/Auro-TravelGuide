# Use official Nginx image
FROM nginx:alpine

# Copy website files into nginx html folder
COPY . /usr/share/nginx/html

# Expose default HTTP port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

