FROM ruby:2.5-slim

# Install dependencies
RUN apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates \
    build-essential \
    libpq-dev \
    nodejs

ENV RAILS_ROOT=/app
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

ENV RAILS_ENV=production
ENV RACK_ENV=production

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem install foreman
RUN bundle install --jobs 20 --retry 5 --without development test

COPY . .

EXPOSE 5000

CMD "/app/scripts/entry"
