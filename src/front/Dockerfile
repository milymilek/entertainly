FROM node:alpine3.17

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 1998

CMD ["npm", "run", "dev", "--", "--host"]
