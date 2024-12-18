FROM node:20-alpine AS build
RUN apk add --no-cache nginx

WORKDIR /server
COPY ./Server/package*.json ./
RUN npm install
COPY ./Server/ ./

WORKDIR /client
COPY ./Client/package*.json ./
RUN npm install
COPY ./Client .
RUN npm run build

COPY ./nginx.conf /etc/nginx/http.d/default.conf
COPY ./Docker/entrypoint /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
