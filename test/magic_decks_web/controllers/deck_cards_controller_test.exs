defmodule MagicDecksWeb.DeckCardsControllerTest do
  use MagicDecksWeb.ConnCase

  import MagicDecks.Factory

  describe "create/2" do
    test "returns created deck_card, when params are valid", %{conn: conn} do
      deck = insert(:deck)

      params = %{
        deck_id: deck.id,
        card: %{
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
          external_id: "15c06ada-0869-4b15-94fc-22858c6bd130"
        }
      }

      response =
        conn
        |> post(Routes.deck_cards_path(conn, :create), params)
        |> json_response(:ok)

      assert %{
               "id" => _id,
               "card_id" => _card_id,
               "deck_id" => _deck_id,
               "quantity" => 1
             } = response
    end

    test "returns error, when params are invalid", %{conn: conn} do
      # deck = insert(:deck)

      params = %{
        deck_id: nil,
        card: %{
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
          external_id: "15c06ada-0869-4b15-94fc-22858c6bd130"
        }
      }

      response =
        conn
        |> post(Routes.deck_cards_path(conn, :create), params)
        |> json_response(:bad_request)

      assert %{
        "errors" => %{
          "deck_id" => ["can't be blank"]
        }
      } == response
    end
  end
end
