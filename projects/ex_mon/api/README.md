# ExMon: API 💻
[![Elixir][Elixir-icon]][Elixir-url]
[![Phoenix][Phoenix-icon]][Phoenix-url]

API to manage trainers and their pokémons.

## Setup

To start your ExMon API:

  * Install dependencies with `mix deps.get`
  * Init the PostgreSQL container with `docker compose up -d`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser and you should see  "Welcome to the ExMon API!".

## Tests

Just run: `mix test`

## Format

To check the project style and format run: `mix format`

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[Elixir-icon]: https://img.shields.io/badge/elixir-663399?style=for-the-badge&logo=elixir&logoColor=white
[Elixir-url]: https://elixir-lang.org
[Phoenix-icon]: https://img.shields.io/badge/phoenix-FF6D31?style=for-the-badge&logo=phoenix&logoColor=white
[Phoenix-url]: https://phoenixframework.org