defmodule MagicDecks.Deck.DeleteTest do
  use MagicDecks.DataCase
  alias MagicDecks.{Deck, Repo}
  alias MagicDecks.Deck.Delete

  describe "call/1" do
    test "deletes deck, when received id is valid" do
      {:ok, deck} =
        %{name: "Some Deck", format: :commander, description: "Some description"}
        |> MagicDecks.create_deck()

      before_count = Repo.aggregate(Deck, :count)

      assert {:ok, _deck} = Delete.call(deck.id)

      after_count = Repo.aggregate(Deck, :count)

      assert after_count < before_count
    end

    test "returns error, when received id has invalid format" do
      invalid_id = "123"

      {:error, result} = Delete.call(invalid_id)

      assert "Invalid id format." == result
    end

    test "returns error, when deck don't exist" do
      deck_id = "d9975d4c-0c8a-496a-8df6-adf8d3e620f6"

      {:error, %{code: code, message: message}} = Delete.call(deck_id)

      assert "Deck not found." == message
      assert 404 == code
    end
  end
end
