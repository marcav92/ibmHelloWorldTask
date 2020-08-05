FROM node:10

# Create app directory
WORKDIR /usr/src/app


# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)



# Bundle app source
COPY ./node-web-server ./node-web-server
COPY ./ibm-hello-world/build ./build

WORKDIR node-web-server
RUN npm install

EXPOSE 5000
CMD [ "node", "server.js" ]
