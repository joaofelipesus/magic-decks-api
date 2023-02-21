defmodule MagicDecks.Card.SearchTest do
  use MagicDecks.DataCase
  import Tesla.Mock

  describe "call(name, lang: lang, method: :db)" do
    test "returns an empty list, when name is not found" do
      {:ok, result} = MagicDecks.Card.Search.call("Akroma", lang: :en, method: :db)

      assert result == []
    end

    test "returns a list of cards, when name is found in en" do
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
        types: ["creature"]
      }
      |> MagicDecks.Card.changeset()
      |> MagicDecks.Repo.insert()

      {:ok, result} = MagicDecks.Card.Search.call("Akroma", lang: :en, method: :db)

      assert [
               %MagicDecks.Card{
                 image_url: "http://example.com/image.jpg",
                 mana_cost: "6{W}{W}{W}",
                 name_en: "Akroma, Angel of Wrath",
                 name_pt: "Akroma, Anjo da Ira",
                 power: 6,
                 rarity: :rare,
                 set: "legions",
                 set_number: 6,
                 toughness: 6,
                 types: ["creature"]
               }
             ] = result
    end

    test "returns a list of cards, when name is found in pt" do
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
        types: ["creature"]
      }
      |> MagicDecks.Card.changeset()
      |> MagicDecks.Repo.insert()

      {:ok, result} = MagicDecks.Card.Search.call("Akroma", lang: :pt, method: :db)

      assert [
               %MagicDecks.Card{
                 image_url: "http://example.com/image.jpg",
                 mana_cost: "6{W}{W}{W}",
                 name_en: "Akroma, Angel of Wrath",
                 name_pt: "Akroma, Anjo da Ira",
                 power: 6,
                 rarity: :rare,
                 set: "legions",
                 set_number: 6,
                 toughness: 6,
                 types: ["creature"]
               }
             ] = result
    end
  end

  describe "call(name, lang:, method: :api)" do
    test "an list of cards from api" do
      mock(fn %{
                method: :get,
                url: "https://api.magicthegathering.io/v1/cards?name=akroma"
              } ->
        %Tesla.Env{status: 200, body: %{"cards" => []}}
      end)

      {:ok, result} = MagicDecks.Card.Search.call("akroma", lang: :en, method: :api)

      assert result == []
    end
  end
end
