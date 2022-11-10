# Builder
FROM node:16-alpine as deps

WORKDIR /usr/src/app

COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm install

FROM node:16-alpine as builder
WORKDIR /usr/src/app

COPY --from=deps /usr/src/app/node_modules .
COPY . .
RUN npm install esbuild
RUN npm run build

# Runner
FROM node:16-alpine

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/out.js .

CMD [ "node", "out.js" ]
