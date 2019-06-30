FROM node:10

WORKDIR /app
COPY nodejs.org/package.json .
RUN npm install
COPY nodejs.org /app
CMD [ "npm", "start" ]
EXPOSE 8080