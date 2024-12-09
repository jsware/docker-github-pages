# Create a GitHub Pages container
FROM ruby:3.3.4

# Update the Ruby bundler and install Jekyll
WORKDIR /tmp
RUN --mount=type=bind,source=docs/Gemfile,target=/tmp/Gemfile bundle install && rm Gemfile.lock
COPY ./serve.sh /serve.sh

WORKDIR /home
ENTRYPOINT [ "/bin/sh", "-c", "/serve.sh" ]
