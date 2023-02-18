defmodule MagicDecks.Deck.UpdateTest do
  use MagicDecks.DataCase
  alias MagicDecks.Deck
  alias MagicDecks.Deck.Update

  describe "call/1" do
    test "updates deck, when params are valid" do
      {:ok, deck} =
        %{name: "Fractius", format: :commander, description: "A deck"}
        |> MagicDecks.create_deck()

      params = %{
        id: deck.id,
        name: "New name",
        format: :standard,
        description: "Deck for fun"
      }

      assert {:ok, %Deck{} = updated_deck} = Update.call(params)

      assert %{
               name: "New name",
               format: :standard,
               description: "Deck for fun"
             } = updated_deck
    end

    test "returns error, when id has invalid format" do
      params = %{id: "1234", name: "New name", format: :standard}

      assert {:error, "Invalid id format."} = Update.call(params)
    end

    test "returns error, when deck don't exist" do
      params = %{id: "12345678-1234-1234-1234-123456789012", name: "New name", format: :standard}

      assert {
               :error,
               %{code: 404, message: "Deck not found."}
             } = Update.call(params)
    end
  end
end
