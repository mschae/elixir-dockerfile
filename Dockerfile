FROM ubuntu:14.04.1

MAINTAINER Michael Schaefermeyer <michael.schaefermeyer@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV ERLANG_VERSION 1:18.1
ENV ELIXIR_VERSION 1.1.0

RUN echo "deb http://packages.erlang-solutions.com/ubuntu trusty contrib" >> /etc/apt/sources.list \
    && apt-key adv --fetch-keys http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc \
    && apt-get update \
    && apt-get install --fix-broken \
    && apt-get autoclean \
    && apt-get autoremove \
    && apt-get install -yf erlang=$ERLANG_VERSION unzip wget git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir /usr/local/elixir

WORKDIR /usr/local/elixir

RUN wget -q https://github.com/elixir-lang/elixir/releases/download/v$ELIXIR_VERSION/Precompiled.zip \
    && unzip Precompiled.zip \
    && rm -f Precompiled.zip \
    && ln -s /usr/local/elixir/bin/elixirc /usr/local/bin/elixirc \
    && ln -s /usr/local/elixir/bin/elixir /usr/local/bin/elixir \
    && ln -s /usr/local/elixir/bin/mix /usr/local/bin/mix \
    && ln -s /usr/local/elixir/bin/iex /usr/local/bin/iex

RUN /usr/local/bin/mix local.hex --force \
    && /usr/local/bin/mix local.rebar --force
