FROM node:20.18-alpine

COPY package.json pnpm-lock.yaml ./

RUN corepack enable

RUN pnpm install

COPY . .

RUN touch db.sqlite && chmod 447 db.sqlite && pnpm migrate

RUN pnpm run build \
    pnpm prune

ENV NITRO_PORT=3000

EXPOSE 3000

CMD [ "node", ".output/server/index.mjs" ]