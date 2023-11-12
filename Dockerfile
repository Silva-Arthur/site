FROM node:latest as angular
WORKDIR /app
COPY package.json /app
RUN npm install --silent
COPY . .
RUN npm run build

FROM nginx:alpine
VOLUME [ "/var/cache/nginx" ]
COPY --from=angular app/dist/site /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf

#construir a img: docker build -t site-teste .
#executar a img:  docker run -p 8081:80 site-teste

##################################
#default
##################################

# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
#FROM node:latest as build

# Set the working directory
#WORKDIR /usr/local/app

# Add the source code to app
#COPY . /usr/local/app/

# Install all the dependencies
#RUN npm install

# Generate the build of the application
#RUN npm run build

# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
#FROM nginx:latest

# Copy the build output to replace the default nginx contents.
#COPY --from=build /usr/local/app/dist/arsf /usr/share/nginx/html
#COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf

##################################
#loiane
##################################

#FROM node:latest as angular
#WORKDIR /app
#COPY package.json /app
#RUN npm install --silent
#COPY . .
#RUN npm run build

#FROM nginx:alpine
#VOLUME [ "/var/cache/nginx" ]
#COPY --from=angular app/dist/arsf /usr/share/nginx/html
#COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf

#construir a img: docker build -t site-teste .
#executar a img:  docker run -p 8081:80 site-teste

##################################
# ARSF
##################################

#FROM node:latest as angular
#WORKDIR /app
#COPY package.json /app
#RUN npm install --silent
#COPY . .
#RUN npm run build

FROM ubuntu
RUN apt-get -y update && apt-get -y install nginx
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf
COPY default /etc/nginx/sites-available/default
#COPY ./config/nginx.conf /etc/nginx/sites-available/default
#COPY ./config/nginx.conf /etc/nginx/sites-enabled/default
COPY --from=angular app/dist/arsf /usr/share/nginx/html
COPY --from=angular app/dist/arsf /var/www/html

# Run the Nginx server
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]








#RUN /etc/init.d/nginx restart
#RUN /etc/init.d/nginx reload
#RUN /etc/init.d/nginx stop
#RUN /etc/init.d/nginx start
