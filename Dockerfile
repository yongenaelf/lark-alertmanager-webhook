FROM cgr.dev/chainguard/node
ENV NODE_ENV=production

WORKDIR /app

COPY --chown=node:node ["package.json", "yarn.lock", "src", "./"]

RUN yarn install --production

ENV CONFIG_PATH=/app/config/config.yaml
EXPOSE 3000
VOLUME /app/config

CMD [ "src/index.js" ]
