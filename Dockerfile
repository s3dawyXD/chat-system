# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.0.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base
FROM base as build

COPY . /app
WORKDIR /app
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev default-libmysqlclient-dev
RUN bundle install 
RUN bundle exec bootsnap precompile app/ lib/

