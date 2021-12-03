# Common build stage
FROM registry.access.redhat.com/ubi8/nodejs-14-minimal as common-build-stage

RUN npm install -g npm

WORKDIR /app

COPY --chown=1001:root . /app

RUN npm install

EXPOSE 3000

# Development build stage
FROM common-build-stage as development-build-stage

ENV NODE_ENV development

CMD ["npm", "run", "dev"]

# Production build stage
FROM common-build-stage as production-build-stage

ENV PORT 3000

ENV NODE_ENV production

RUN npm run build

RUN chmod -R 775 /app

CMD ["npm", "run", "start"]
