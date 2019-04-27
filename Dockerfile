FROM ruby:2.4.6

# Install dependencies
RUN apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates \
    build-essential \
    libpq-dev \
    nodejs

ENV LANG C.UTF-8
ENV RAILS_ROOT=/app
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV NODE_ENV=production

COPY Gemfile Gemfile.lock ./

RUN gem install foreman
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without development test

COPY . ./

RUN bundle exec rake assets:precompile

EXPOSE 5000

CMD "/app/scripts/entrypoint"
