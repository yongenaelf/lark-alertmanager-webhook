FROM cgr.dev/chainguard/node:latest-dev AS install
ENV NODE_ENV=production

WORKDIR /app

COPY --chown=node:node ["package.json", "yarn.lock", "./"]

RUN yarn install --production

FROM cgr.dev/chainguard/node

WORKDIR /app

COPY --from=install --chown=node:node ["/app/node_modules/", "./node_modules/"]
COPY --chown=node:node ["package.json", "./"]
COPY --chown=node:node ["src", "./src"]

ENV CONFIG_PATH=/app/config/config.yaml
EXPOSE 3000
VOLUME /app/config

CMD [ "src/index.js" ]
