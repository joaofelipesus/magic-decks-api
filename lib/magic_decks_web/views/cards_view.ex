defmodule MagicDecksWeb.CardsView do
  use MagicDecksWeb, :view

  def render("index.json", %{cards: cards}) do
    cards
    |> Enum.map(fn card ->
      %{
        id: card.id,
        name_en: card.name_en,
        types: card.types,
        power: card.power,
        toughness: card.toughness,
        colors: card.colors,
        mana_cost: card.mana_cost,
        rarity: card.rarity,
        set: card.set,
        set_number: card.set_number,
        image_url: card.image_url,
        name_pt: card.name_pt,
        external_id: card.external_id
      }
    end)
  end

  def render("show.json", %{card: card}) do
    %{
      id: card.id,
      name_en: card.name_en,
      types: card.types,
      power: card.power,
      toughness: card.toughness,
      colors: card.colors,
      mana_cost: card.mana_cost,
      rarity: card.rarity,
      set: card.set,
      set_number: card.set_number,
      image_url: card.image_url,
      name_pt: card.name_pt,
      external_id: card.external_id
    }
  end
end
