FROM node:14.17.4-alpine

# establece el directorio de trabajo (cd /usr/src/)
WORKDIR /usr/src

RUN npm install -g http-server

EXPOSE 8081

COPY ["/dist/spa/", "/usr/src/"]

# ejecuta el commando 
CMD ["http-server","-p","8081"]