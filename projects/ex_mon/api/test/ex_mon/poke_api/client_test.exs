defmodule ExMon.PokeApi.ClientTest do
  use ExUnit.Case

  import Tesla.Mock

  alias ExMon.PokeApi.Client

  @base_url "https://pokeapi.co/api/v2/pokemon/"

  describe "get_pokemon/1" do
    test "when there is a pokemon with the given name, returns the pokemon" do
      mock(fn
        %{method: :get, url: @base_url <> "pikachu"} ->
          %Tesla.Env{status: 200, body: %{name: "pikachu"}}
      end)

      assert {:ok, %{name: "pikachu"}} = Client.get_pokemon("pikachu")
    end

    test "when there is no a pokemon with the given name, returns the pokemon" do
      mock(fn
        %{method: :get, url: @base_url <> "pikaxu"} ->
          %Tesla.Env{status: 404}
      end)

      assert {:error, "Pokemon not found!"} = Client.get_pokemon("pikaxu")
    end

    test "when there is an unexpected error, returns the error" do
      mock(fn
        %{method: :get, url: @base_url <> "pikachu"} ->
          {:error, :timeout}
      end)

      assert {:error, :timeout} = Client.get_pokemon("pikachu")
    end
  end
end
