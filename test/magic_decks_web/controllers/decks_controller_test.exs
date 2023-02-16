defmodule MagicDecksWeb.DecksControllerTest do
  use MagicDecksWeb.ConnCase

  # TODO: add error teste case
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
  end
end
