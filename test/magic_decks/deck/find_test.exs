defmodule MagicDecks.Deck.FindTest do
  use MagicDecks.DataCase

  alias MagicDecks.Deck.Find

  describe "call/1" do
    test "return deck, when received id belongs to a register" do
      {:ok, deck} = MagicDecks.create_deck(%{name: "Fractius", format: :commander, decription: ""})

      {:ok, result} = Find.call(deck.id)

      assert %MagicDecks.Deck{
        description: nil,
        format: :commander,
        id: _id,
        name: "Fractius",
      } = result
    end

    test "returns error message, when received id has invalid format" do
      {:error, message} = Find.call("42")

      assert message == "Invalid id format."
    end

    test "returns error message, when elemnt not found" do
      fake_uuid = "9314b4a2-7280-431a-989e-63595cdfaa19"
      {:error, message} = Find.call(fake_uuid)

      assert message == "Deck not found."
    end
  end
end
