FROM ruby:2.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /escambo
COPY Gemfile /escambo/Gemfile
COPY Gemfile.lock /escambo/Gemfile.lock
RUN bundle install
COPY . /escambo

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3001

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]