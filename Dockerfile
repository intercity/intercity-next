FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev
RUN wget -q https://github.com/ariya/phantomjs/releases/download/2.1.3/phantomjs
RUN mv phantomjs /usr/local/bin
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
CMD bundle exec rails s
