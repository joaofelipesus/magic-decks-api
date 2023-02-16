defmodule MagicDecksWeb.DecksControllerTest do
  use MagicDecksWeb.ConnCase

  describe "#create" do
    test "returns created deck, when params are valid", %{conn: conn} do
      params = %{
        "name" => "Jhoira storm",
        "format" => "commander",
        "description" => "Infinite turns"
      }

      response =
        conn
        |> post(Routes.decks_path(conn, :create, params))
        |> json_response(:created)

      assert %{
        "description" => "Infinite turns",
        "format" => "commander",
        "id" => _id,
        "inserted_at" => _inserted_at,
        "name" => "Jhoira storm"
      } = response
    end

    test "returns error messages, when params has problems", %{conn: conn} do
      params = %{
        "name" => nil,
        "format" => "commander",
        "description" => "Infinite turns"
      }

      response =
        conn
        |> post(Routes.decks_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"errors" => %{"name" => ["can't be blank"]}} == response
    end
  end

  describe "show/2" do
    test "return a deck, when received id belong to a deck", %{conn: conn} do
      {:ok, deck} =
        %{name: "Goblins", format: :commander, description: "aggro"}
        |> MagicDecks.create_deck()

      response =
        conn
        |> get(Routes.decks_path(conn, :show, deck.id))
        |> json_response(:ok)

      assert %{
        "description" => "aggro",
        "format" => "commander",
        "id" => _id,
        "inserted_at" => _inserted_at,
        "name" => "Goblins"
      } = response
    end

    test "returns bad request status with error message, when id format is invalid", %{conn: conn} do
      response =
        conn
        |> get(Routes.decks_path(conn, :show, "123"))
        |> json_response(:bad_request)

      assert %{"errors" => ["Invalid id format."]} == response
    end

    test "returns not found status with error message, when deck don't exist", %{conn: conn} do
      fake_id = "9314b4a2-7280-431a-989e-63595cdfaa19"

      response =
        conn
        |> get(Routes.decks_path(conn, :show, fake_id))
        |> json_response(:not_found)

      assert response == %{"errors" => ["Deck not found."]}
    end
  end
end
