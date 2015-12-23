FROM erlang:18.1

MAINTAINER Michael Schaefermeyer <michael.schaefermeyer@gmail.com>

ENV TERM xterm
ENV ELIXIR_VERSION 1.2.0-rc.0

RUN apt-get update \
    && apt-get install -y unzip \
    && rm -rf /usr/src/otp-src /var/lib/apt/lists/*

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
