FROM ruby:3.1.4-alpine

ENV TZ=America/Sao_Paulo

ARG USER_ID=1000
ARG GROUP_ID=1000

ENV INSTALL_PATH /app

RUN apk --no-cache add \
  build-base \
  postgresql-dev \
  imagemagick \
  tzdata \
  curl \
  gnupg \
  nodejs \
  git \ 
  yarn && \
  rm -rf /var/cache/apk/*

RUN mkdir -p $INSTALL_PATH

RUN addgroup -g $GROUP_ID appuser && \
  adduser -D -u $USER_ID -G appuser -h $INSTALL_PATH appuser

USER appuser

WORKDIR $INSTALL_PATH

COPY . .