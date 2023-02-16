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
end
