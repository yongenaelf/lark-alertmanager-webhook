FROM cgr.dev/chainguard/node:latest-dev AS build
ENV NODE_ENV=production

WORKDIR /app

COPY --chown=node:node ["package.json", "yarn.lock", "src", "./"]

RUN yarn install --production

FROM cgr.dev/chainguard/node

WORKDIR /app

COPY --from=build --chown=node:node ["/app/node_modules", "/src", "./"]

ENV CONFIG_PATH=/app/config/config.yaml
EXPOSE 3000
VOLUME /app/config

CMD [ "src/index.js" ]
