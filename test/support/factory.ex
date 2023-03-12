defmodule MagicDecks.Factory do
  use ExMachina.Ecto, repo: MagicDecks.Repo

  def card_factory do
    %MagicDecks.Card{
      name_pt: "Akroma, Anjo da Ira",
      name_en: "Akroma, Angel of Wrath",
      types: ["creature"],
      set: "legions",
      set_number: 6,
      mana_cost: "6{W}{W}{W}",
      rarity: :rare,
      power: 6,
      toughness: 6,
      image_url: "http://example.com/image.jpg",
      external_id: "e4c94bde-8bd2-5b5d-bd7b-aa7c4b0b2fcd",
      colors: ["white"]
    }
  end

  def card_params_factory do
    %{
      name_pt: "Akroma, Anjo da Ira",
      name_en: "Akroma, Angel of Wrath",
      types: ["creature"],
      set: "legions",
      set_number: 6,
      mana_cost: "6{W}{W}{W}",
      rarity: :rare,
      power: 6,
      toughness: 6,
      image_url: "http://example.com/image.jpg",
      external_id: "e4c94bde-8bd2-5b5d-bd7b-aa7c4b0b2fcd",
      colors: ["white"]
    }
  end

  def deck_factory do
    %MagicDecks.Deck{
      name: "Goblins",
      description: "Goblin tokens deck"
    }
  end
end
