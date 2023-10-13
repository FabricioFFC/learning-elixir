FROM elixir:1.15-alpine

RUN apk add --no-cache build-base

WORKDIR /app

COPY . ./

RUN mix deps.get

EXPOSE 4000

CMD mix phx.server
