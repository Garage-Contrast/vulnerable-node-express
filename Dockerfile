# Common build stage
FROM registry.access.redhat.com/ubi8/nodejs-14-minimal as common-build-stage

WORKDIR /app

COPY --chown=1001:1001 . /app

RUN npm install

EXPOSE 3000

# Development build stage
FROM common-build-stage as development-build-stage

ENV NODE_ENV development

CMD ["npm", "run", "dev"]

# Production build stage
FROM common-build-stage as production-build-stage

ENV NODE_ENV production

CMD ["npm", "run", "start"]
