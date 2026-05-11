# Multi step Docker build for production

# Builder stage where we run the first base image, install our dependencies and generate the static JS content to server from NGINX
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build 

#Run stage (when add a new FROM statement, it says it's the end of the block above)
#Copy content from the build stage to the directory in NGINX that servers the files 
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

