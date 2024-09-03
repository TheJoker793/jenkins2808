FROM node:18 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod
FROM nginx:latest

COPY --from=build /app/dist/jenkins2206/browser/* /usr/share/nginx/html/
