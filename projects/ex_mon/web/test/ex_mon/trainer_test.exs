defmodule ExMon.TrainerTest do
  use ExMon.DataCase

  alias ExMon.Trainer

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      # Setup
      params = %{name: "Ash", password: "123456"}

      # Exercise
      response = Trainer.changeset(params)

      # Verify
      assert %Ecto.Changeset{
               changes: %{
                 name: "Ash",
                 password: "123456"
               },
               errors: [],
               data: %ExMon.Trainer{},
               valid?: true
             } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      # Setup
      params = %{password: "123456"}

      # Exercise
      response = Trainer.changeset(params)

      # Verify
      assert %Ecto.Changeset{
               changes: %{
                 password: "123456"
               },
               data: %ExMon.Trainer{},
               valid?: false
             } = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a trainer struct" do
      # Setup
      params = %{name: "Ash", password: "123456"}

      # Exercise
      response = Trainer.build(params)

      # Verify
      assert {:ok, %Trainer{name: "Ash", password: "123456"}} = response
    end

    test "when there are invalid params, returns an error" do
      # Setup
      params = %{password: "123456"}

      # Exercise
      {:error, response} = Trainer.build(params)

      # Verify
      assert %Ecto.Changeset{valid?: false} = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end
end
