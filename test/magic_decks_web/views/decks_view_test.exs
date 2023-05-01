defmodule MagicDecksWeb.DecksViewTest do
  use MagicDecksWeb.ConnCase

  import MagicDecks.Factory
  import Phoenix.View

  describe "show/2" do
    test "returns a parsed deck" do
      {:ok, %MagicDecks.Deck{id: deck_id}} =
        %{name: "Fractius aggro", format: :standard, description: "Deck forfun"}
        |> MagicDecks.create_deck()

      card = insert(:card)

      MagicDecks.create_deck_card(%{card: %{external_id: card.external_id}, deck_id: deck_id})

      {:ok, deck} = MagicDecks.find_deck(deck_id)

      result = render(MagicDecksWeb.DecksView, "show.json", %{deck: deck})

      assert %{
               description: "Deck forfun",
               format: :standard,
               id: _id,
               inserted_at: _inserted_at,
               name: "Fractius aggro"
             } = result
    end
  end

  describe "upsert/2" do
    test "returns a parsed deck" do
      {:ok, deck} =
        %{name: "Fractius aggro", format: :standard, description: "Deck forfun"}
        |> MagicDecks.create_deck()

      result = render(MagicDecksWeb.DecksView, "upsert.json", %{deck: deck})

      assert %{
               description: "Deck forfun",
               format: :standard,
               id: _id,
               inserted_at: _inserted_at,
               name: "Fractius aggro"
             } = result
    end
  end

  describe "index/2" do
    test "returns a list of parsed decks" do
      {:ok, first_deck} =
        %{name: "Fractius aggro", format: :standard, description: "Deck forfun"}
        |> MagicDecks.create_deck()

      {:ok, second_deck} =
        %{name: "Goblins aggro", format: :standard, description: "Deck tornament"}
        |> MagicDecks.create_deck()

      result = render(MagicDecksWeb.DecksView, "index.json", %{decks: [first_deck, second_deck]})

      assert [
               %{
                 description: "Deck forfun",
                 format: :standard,
                 id: _first_deck_id,
                 inserted_at: _first_deck_inserted_at,
                 name: "Fractius aggro"
               },
               %{
                 description: "Deck tornament",
                 format: :standard,
                 id: _second_deck_id,
                 inserted_at: _second_deck_inserted_at,
                 name: "Goblins aggro"
               }
             ] = result
    end
  end
end
