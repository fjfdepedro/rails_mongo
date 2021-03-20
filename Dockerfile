FROM ruby:2.5.1-slim AS builder

RUN apt-get update -qq && apt-get install -y build-essential \
    libpq-dev curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bin/bash -\
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | \
    apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
    tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq && apt-get install -y nodejs yarn

WORKDIR /rails_mongo
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . /rails_mongo

FROM ruby:2.5.1-slim

RUN apt-get update -qq && apt-get install -y build-essential \
    libpq-dev curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bin/bash -\
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | \
    apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
    tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq && apt-get install -y nodejs yarn

WORKDIR /rails_mongo

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /rails_mongo /rails_mongo

RUN rm -f tmp/pids/server.pid
RUN RAILS_ENV=production
CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]
EXPOSE 3000