FROM ruby:3.1.4-slim

ENV TZ=America/Sao_Paulo

ARG USER_ID=1000
ARG GROUP_ID=1000

ENV INSTALL_PATH /app

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  imagemagick \
  tzdata \
  curl \
  nano \
  gnupg \
  git && \
  rm -rf /var/lib/apt/lists/*

RUN groupadd -g $GROUP_ID appuser && \
  useradd -r -u $USER_ID -g $GROUP_ID -m -d $INSTALL_PATH -s /sbin/nologin appuser

USER appuser

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

COPY . .
