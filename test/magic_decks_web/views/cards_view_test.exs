defmodule MagicDecksWeb.CardsViewTest do
  use MagicDecksWeb.ConnCase

  import Phoenix.View

  defp card_params do
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
      colors: ["white"],
      external_id: "e4c94bde-8bd2-5b5d-bd7b-aa7c4b0b2fcd"
    }
  end

  def create_card do
    card_params()
    |> MagicDecks.create_card()
  end

  describe "render('index.json', %{cards: cards})" do
    test "returns a list of parsed objects" do
      {:ok, card} = create_card()

      result = render(MagicDecksWeb.CardsView, "index.json", %{cards: [card]})

      assert [
               %{
                 id: _id,
                 name_en: "Akroma, Angel of Wrath",
                 types: ["creature"],
                 power: 6,
                 toughness: 6,
                 colors: ["white"],
                 mana_cost: "6{W}{W}{W}",
                 rarity: :rare,
                 set: "legions",
                 set_number: 6,
                 image_url: "http://example.com/image.jpg",
                 name_pt: "Akroma, Anjo da Ira",
                 external_id: "e4c94bde-8bd2-5b5d-bd7b-aa7c4b0b2fcd"
               }
             ] = result
    end
  end

  describe "render('show.json', %{card: card})" do
    test "returns a parsed card object" do
      {:ok, card} = create_card()

      result = render(MagicDecksWeb.CardsView, "show.json", %{card: card})

      assert %{
               id: _id,
               name_en: "Akroma, Angel of Wrath",
               types: ["creature"],
               power: 6,
               toughness: 6,
               colors: ["white"],
               mana_cost: "6{W}{W}{W}",
               rarity: :rare,
               set: "legions",
               set_number: 6,
               image_url: "http://example.com/image.jpg",
               name_pt: "Akroma, Anjo da Ira",
               external_id: "e4c94bde-8bd2-5b5d-bd7b-aa7c4b0b2fcd"
             } = result
    end
  end
end
