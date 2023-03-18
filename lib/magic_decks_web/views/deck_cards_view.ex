defmodule MagicDecksWeb.DeckCardsView do
  use MagicDecksWeb, :view

  def render("ok.json", %{deck_card: deck_card}) do
    %{
      id: deck_card.id,
      deck_id: deck_card.deck_id,
      card_id: deck_card.card_id,
      quantity: deck_card.quantity
    }
  end
end
