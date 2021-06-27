FROM node:12-alpine as base
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build && npm prune --production

FROM node:lts-slim
COPY --from=base package*.json ./
COPY --from=base /node_modules ./node_modules
COPY --from=base /dist ./dist
EXPOSE 4000
CMD ["node", "dist/main.js"]
