#image for nginx to serve angular app
FROM nginx:latest
COPY default.conf /etc/nginx/conf.d/default.conf
COPY dist/angular-app/ /usr/share/nginx/html
