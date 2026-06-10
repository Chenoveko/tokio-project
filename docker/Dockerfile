FROM node:alpine3.23 AS builder

WORKDIR /app

COPY ../techwave-app/package*.json ./

RUN npm ci

COPY ../techwave-app .

RUN npm run build

FROM nginx:1.31

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]