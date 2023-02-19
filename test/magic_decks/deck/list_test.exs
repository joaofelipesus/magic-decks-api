defmodule MagicDecks.Deck.ListTest do
  use MagicDecks.DataCase

  describe "call/0" do
    test "returns all decks sorted by name" do
      {:ok, deck1} = MagicDecks.create_deck(%{name: "A", format: :commander})
      {:ok, deck2} = MagicDecks.create_deck(%{name: "B", format: :commander})
      {:ok, deck3} = MagicDecks.create_deck(%{name: "C", format: :commander})

      assert MagicDecks.Deck.List.call() == [
               deck1,
               deck2,
               deck3
             ]
    end
  end

  describe "call(%{format: format})" do
    test "returns decks filter by format" do
      {:ok, commander_deck} = MagicDecks.create_deck(%{name: "A", format: :commander})
      {:ok, _modern_deck} = MagicDecks.create_deck(%{name: "B", format: :modern})

      assert MagicDecks.Deck.List.call(%{format: :commander}) == [
               commander_deck
             ]
    end
  end
end
