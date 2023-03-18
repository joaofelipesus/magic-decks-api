defmodule MagicDecksWeb.DeckCardsViewTest do
  use MagicDecksWeb.ConnCase

  import MagicDecks.Factory

  import Phoenix.View

  describe "render('ok.json', %{deck_card: deck_card})" do
    test "returns a parsed deck_card object" do
      deck_card = insert(:deck_card)

      result = render(MagicDecksWeb.DeckCardsView, "ok.json", %{deck_card: deck_card})

      assert %{
               id: _id,
               card_id: _card_id,
               deck_id: _deck_id,
               quantity: 1
             } = result
    end
  end
end
