#Stage 1 base image for nodejs
FROM node:latest as node
WORKDIR /app
COPY . .
RUN npm install --force
RUN npm run cibuild

#Stage 2 image for nginx to serve angular app
FROM nginx:latest
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=node /app/dist/angular-app /usr/share/nginx/html
