FROM ruby:3.1.4

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  build-essential libpq-dev imagemagick git-all nano

ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ENV BUNDLE_PATH /usr/local/bundle

COPY Gemfile Gemfile.lock ./

COPY . .