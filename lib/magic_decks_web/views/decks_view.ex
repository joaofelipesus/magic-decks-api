defmodule MagicDecksWeb.DecksView do
  use MagicDecksWeb, :view

  def render("index.json", %{decks: decks}) do
    Enum.map(decks, fn deck ->
      build_deck(deck)
    end)
  end

  def render("show.json", %{deck: deck}) do
    %{
      id: deck.id,
      name: deck.name,
      format: deck.format,
      description: deck.description,
      inserted_at: deck.inserted_at,
      deck_cards:
        Enum.map(deck.deck_cards, fn deck_card ->
          build_deck_card(deck_card)
        end)
    }
  end

  def render("upsert.json", %{deck: deck}) do
    %{
      id: deck.id,
      name: deck.name,
      format: deck.format,
      description: deck.description,
      inserted_at: deck.inserted_at
    }
  end

  defp build_deck(deck) do
    %{
      id: deck.id,
      name: deck.name,
      format: deck.format,
      description: deck.description,
      inserted_at: deck.inserted_at
    }
  end

  defp build_deck_card(deck_card) do
    %{
      id: deck_card.id,
      quantity: deck_card.quantity,
      card: %{
        id: deck_card.card.id,
        name_en: deck_card.card.name_en,
        types: deck_card.card.types,
        power: deck_card.card.power,
        toughness: deck_card.card.toughness,
        colors: deck_card.card.colors,
        mana_cost: deck_card.card.mana_cost,
        rarity: deck_card.card.rarity,
        set: deck_card.card.set,
        set_number: deck_card.card.set_number,
        image_url: deck_card.card.image_url,
        name_pt: deck_card.card.name_pt,
        external_id: deck_card.card.external_id
      }
    }
  end
end
