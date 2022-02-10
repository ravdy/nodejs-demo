FROM node:latest

COPY nodeapp/* /usr/src/app/
RUN npm install
EXPOSE 3000
CMD [ "node", "index.js" ]
