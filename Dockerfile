FROM ruby:2.5.1

RUN mkdir -p /trabalho-ia
WORKDIR /trabalho-ia
COPY . /trabalho-ia
RUN bundle install
