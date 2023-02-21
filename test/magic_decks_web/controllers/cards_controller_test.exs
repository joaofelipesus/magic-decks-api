defmodule MagicDecksWeb.CardsControllerTest do
  use MagicDecksWeb.ConnCase

  alias MagicDecks.{Card, Repo}

  def create_card() do
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
  end

  describe "search/2" do
    test "returns a list with cards returned by Find service", %{conn: conn} do
      {:ok, _card} = create_card()

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

  describe "create/2" do
    test "returns created card, when params are valid", %{conn: conn} do
      params = %{
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

      response =
        conn
        |> post(Routes.cards_path(conn, :create), params)
        |> json_response(:created)

      assert %{
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
             } = response
    end

    test "returns error messages, when params has errors", %{conn: conn} do
      params = %{
        name_pt: "Akroma, Anjo da Ira",
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

      response =
        conn
        |> post(Routes.cards_path(conn, :create), params)
        |> json_response(:bad_request)

      assert %{"errors" => %{"name_en" => ["can't be blank"]}} == response
    end
  end

  describe "index/2" do
    test "returns cards", %{conn: conn} do
      {:ok, _card} = create_card()

      response =
        conn
        |> get(Routes.cards_path(conn, :index, %{}))
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
