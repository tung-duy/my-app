FROM node:alpine

EXPOSE 3010

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

CMD ["npm", "start"]