# Builder
FROM node:16-alpine as builder

WORKDIR /usr/src/app

COPY . .

RUN npm install
RUN npm install esbuild
RUN npm run build

# Runner
FROM node:16-alpine

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/out.js .

CMD [ "node", "out.js" ]
