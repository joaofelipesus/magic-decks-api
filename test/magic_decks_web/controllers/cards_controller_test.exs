defmodule MagicDecksWeb.CardsControllerTest do
  use MagicDecksWeb.ConnCase

  alias MagicDecks.{Card, Repo}

  describe "search/2" do
    test "returns a list with cards returned by Find service", %{conn: conn} do
      {:ok, _card} =
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
          colors: ["white"]
        }
        |> Card.changeset()
        |> Repo.insert()

      params = %{"name" => "Akroma", "lang" => "en", "method" => "db"}

      response =
        conn
        |> get(Routes.cards_path(conn, :search, params))
        |> json_response(:ok)

      assert [
               %{
                 "id" => _id,
                 "name_en" => "Akroma, Angel of Wrath",
                 "types" => ["creature"],
                 "power" => 6,
                 "toughness" => 6,
                 "colors" => ["white"],
                 "mana_cost" => "6{W}{W}{W}",
                 "rarity" => "rare",
                 "set" => "legions",
                 "set_number" => 6,
                 "image_url" => "http://example.com/image.jpg",
                 "name_pt" => "Akroma, Anjo da Ira"
               }
             ] = response
    end
  end
end
