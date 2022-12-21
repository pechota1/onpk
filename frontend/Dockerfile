FROM node:12-alpine as build
WORKDIR /app
COPY package.json package-lock.json* ./
RUN yarn install
COPY . .
CMD [ "node", "server.js" ]


FROM nginx:stable-alpine
COPY --from=build /app/env.sh /docker-entrypoint.d
COPY conf.d/default.conf /etc/nginx/conf.d

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]





