# https://nodejs.org/en/about/releases/
# https://github.com/nodejs/Release#readme
FROM node:12-alpine3.11

RUN apk add --no-cache bash tini

EXPOSE 30021

# override some config defaults with values that will work better for docker
ENV ME_CONFIG_EDITORTHEME="default" \
    ME_CONFIG_MONGODB_SERVER="mongo" \
    ME_CONFIG_MONGODB_ENABLE_ADMIN="true" \
    ME_CONFIG_BASICAUTH_USERNAME="root" \
    ME_CONFIG_BASICAUTH_PASSWORD="Deneme123!" \
    VCAP_APP_HOST="10.50.20.137"

ENV MONGO_EXPRESS 0.54.0

RUN set -eux; \
	apk add --no-cache --virtual .me-install-deps git; \
	npm install mongo-express@$MONGO_EXPRESS; \
	apk del --no-network .me-install-deps

COPY docker-entrypoint.sh /

WORKDIR /node_modules/mongo-express

RUN cp config.default.js config.js

ENTRYPOINT [ "tini", "--", "/docker-entrypoint.sh"]
CMD ["mongo-express"]
