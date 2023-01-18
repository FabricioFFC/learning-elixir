defmodule ExMonWeb.TrainerPokemonsView do
  use ExMonWeb, :view

  alias ExMon.Trainer.Pokemon

  def render("create.json", %{pokemon: pokemon}) do
    %{
      message: "Pokemon created",
      pokemon: %{
        id: pokemon.id,
        name: pokemon.name,
        inserted_at: pokemon.inserted_at,
        nickname: pokemon.nickname,
        weight: pokemon.weight,
        trainer_id: pokemon.trainer_id,
        types: pokemon.types
      }
    }
  end

  def render("show.json", %{pokemon: pokemon}) do
    %{
      pokemon: %{
        id: pokemon.id,
        name: pokemon.name,
        inserted_at: pokemon.inserted_at,
        nickname: pokemon.nickname,
        weight: pokemon.weight,
        trainer: %{trainer_id: pokemon.trainer_id, name: pokemon.name},
        types: pokemon.types
      }
    }
  end

  def render("update.json", %{pokemon: pokemon}) do
    %{
      message: "Pokemon updated",
      pokemon: %{
        id: pokemon.id,
        name: pokemon.name,
        inserted_at: pokemon.inserted_at,
        nickname: pokemon.nickname,
        weight: pokemon.weight,
        trainer_id: pokemon.trainer_id,
        types: pokemon.types
      }
    }
  end
end
