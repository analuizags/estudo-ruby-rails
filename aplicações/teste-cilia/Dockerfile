# syntax=docker/dockerfile:1
FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /teste-cilia
COPY Gemfile /teste-cilia/Gemfile
COPY Gemfile.lock /teste-cilia/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3001

CMD ["rails", "server", "-b", "0.0.0.0"]