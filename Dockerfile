FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
ENV APP_HOST=127.0.0.1
RUN bundle exec rake assets:precompile
CMD bundle exec rails s
EXPOSE 3000
