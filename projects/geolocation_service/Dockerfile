FROM elixir:1.15-alpine

# Appended by flyctl
ENV ECTO_IPV6 true
ENV ERL_AFLAGS "-proto_dist inet6_tcp"

RUN apk add --no-cache build-base

WORKDIR /app

COPY . ./

RUN mix deps.get

EXPOSE 4000

CMD mix phx.server
