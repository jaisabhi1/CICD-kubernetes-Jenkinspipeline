FROM node:alpine

EXPOSE 2000

RUN mkdir -p /app

WORKDIR /app

ADD server.js ./

COPY package.json ./

CMD ["npm","start"]