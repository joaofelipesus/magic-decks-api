defmodule MagicDecksWeb.CardsViewTest do
  use MagicDecksWeb.ConnCase

  import Phoenix.View

  alias MagicDecks.{Card, Repo}

  describe "render('index.json', %{cards: cards})" do
    test "returns a list of parsed objects" do
      {:ok, card} = %{
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
        colors: ["white"]
      }
      |>Card.changeset()
      |> Repo.insert()

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
          name_pt: "Akroma, Anjo da Ira"
        }
      ] = result
    end
  end
end
