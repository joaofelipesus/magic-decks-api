defmodule MagicDecks.Deck.CreateTest do
  use MagicDecks.DataCase
  alias MagicDecks.Deck.Create
  alias MagicDecks.{Deck, Repo}

  describe "call/1" do
    test "creates a new deck, when params are valid" do
      before_count = Repo.aggregate(Deck, :count)

      {:ok, deck} =
        %{name: "Fractius aggro", format: :commander, description: "Some nice deck"}
        |> Create.call()

      after_count = Repo.aggregate(Deck, :count)

      assert after_count > before_count

      assert %Deck{
               id: _id,
               name: "Fractius aggro",
               format: :commander,
               description: "Some nice deck"
             } = deck
    end

    test "returns a invalid changeset, when params has errors" do
      {:error, result} =
        %{name: "Fractius aggro", description: "Some nice deck"}
        |> Create.call()

      assert %Ecto.Changeset{
               valid?: false
             } = result
    end
  end
end
