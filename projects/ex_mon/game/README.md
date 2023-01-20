# ExMon: Game 🎮
[![Elixir][Elixir-icon]][Elixir-url]

A turn-based game inspired by Pokémon. Using Elixir's interactive shell (iex) to run the game.

## Setup

You need to have Elixir 1.14 on your machine. With Elixir installed you just need to install the projects dependencies running `mix deps.get`.

In a new iex session `iex -S mix`, execute the following code to init a new game:

```elixir
player = ExMon.create_player("Player 1", :chute, :soco, :cura)

ExMon.start_game(player)

ExMon.make_move(:chute)

ExMon.make_move(:soco)
```

## Tests

Just run: `mix test`

If you need to also check the test coverage you can:

* `mix coveralls.html` to generate the HTML report
* `mix coveralls` to generate a report inline 

## Format

To check the project style and format run: `mix format`

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[Elixir-icon]: https://img.shields.io/badge/elixir-663399?style=for-the-badge&logo=elixir&logoColor=white
[Elixir-url]: https://elixir-lang.org