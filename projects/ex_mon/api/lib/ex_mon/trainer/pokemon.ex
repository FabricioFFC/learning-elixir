defmodule Exmon.Trainer.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExMon.{Trainer, Repo}

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "pokemons" do
    field :name, :string
    field :nickname, :string
    field :weight, :integer
    field :types, {:array, :string}
    belongs_to(:trainer, Trainer)
    timestamps()
  end

  @required [:name, :nickname, :weight, :types, :trainer_id]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:nickname, min: 2)
    |> validate_pokemon_trainer_exists()
  end

  def update_changeset(pokemon, params) do
    pokemon
    |> cast(params, [:nickname])
    |> validate_required([:nickname])
    |> validate_required(:nickname, min: 2)
    |> validate_pokemon_trainer_exists()
  end

  defp validate_pokemon_trainer_exists(changeset) do
    validate_change(changeset, :trainer_id, fn _, trainer_id ->
      case Repo.get(Trainer, trainer_id) do
        nil -> [{:trainer_id, "not found"}]
        _trainer -> []
      end
    end)
  end
end