# Build stateful-hello docker image

# Base:
# https://hub.docker.com/_/node/
#FROM node:12-alpine
# https://github.com/mhart/alpine-node
FROM mhart/alpine-node:slim
#FROM mhart/alpine-node:6

WORKDIR /app
COPY . /app
RUN mkdir /app/data
EXPOSE 3000
CMD ["node", "/app/server.js"]
