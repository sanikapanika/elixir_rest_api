FROM elixir:1.10.1
ENV DEBIAN_FRONTEND=noninteractive

ENV HOME=/opt/app/ TERM=xterm

RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /opt/app
ENV MIX_ENV=prod REPLACE_OS_VARS=true

ADD lib lib
ADD priv priv
ADD .formatter.exs .formatter.exs

COPY mix.exs mix.lock ./
RUN mix deps.get -only prod
COPY config ./config
RUN mix deps.compile

RUN mix release
EXPOSE 4000
ENTRYPOINT ["_build/prod/rel/prod/bin/prod", "start"]