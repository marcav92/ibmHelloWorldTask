FROM node:10

# Create app directory
WORKDIR /usr/src/app


# Copy Source files
COPY ./node-web-server ./node-web-server
COPY ./ibm-hello-world/build ./build

WORKDIR node-web-server
RUN npm install

EXPOSE 5000
CMD [ "node", "server.js" ]
