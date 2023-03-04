defmodule MagicDecks.Card.ListTest do
  use MagicDecks.DataCase

  alias MagicDecks.Card.List

  def create_first_card() do
    %{
      image_url: "http://example.com/image.jpg",
      mana_cost: "6{W}{W}{W}",
      name_en: "Akroma, Angel of Wrath",
      name_pt: "Akroma, Anjo da Ira",
      power: 6,
      rarity: :rare,
      set: "legions",
      set_number: 6,
      toughness: 6,
      types: ["creature"],
      external_id: "e4c94bde-8bd2-5b5d-bd7b-aa7c4b0b2fcd"
    }
    |> MagicDecks.create_card()
  end

  def create_second_card() do
    %{
      image_url: "http://example.com/image.jpg",
      mana_cost: "6{W}{W}{W}",
      name_en: "ZAkroma, Angel of Wrath",
      name_pt: "ZAkroma, Anjo da Ira",
      power: 16,
      rarity: :rare,
      set: "legions",
      set_number: 6,
      toughness: 6,
      types: ["creature"],
      external_id: "cabe754b-ddb0-4f54-a182-2db436c286de"
    }
    |> MagicDecks.create_card()
  end

  describe "call/0" do
    test "returns a list with all cards order by name_en" do
      create_first_card()
      create_second_card()

      {:ok, [first, second]} = List.call()

      assert first.name_en == "Akroma, Angel of Wrath"
      assert second.name_en == "ZAkroma, Angel of Wrath"
    end
  end
end
