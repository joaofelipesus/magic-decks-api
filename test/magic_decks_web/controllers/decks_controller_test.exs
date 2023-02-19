defmodule MagicDecksWeb.DecksControllerTest do
  use MagicDecksWeb.ConnCase
  alias MagicDecks.Deck

  describe "#index" do
    test "returns a list of all decks, when don't receive any filter param", %{conn: conn} do
      {:ok, _} =
        %{
          "name" => "Fractius aggro",
          "format" => "standard",
          "description" => "Deck forfun"
        }
        |> MagicDecks.create_deck()

      {:ok, _} =
        %{
          "name" => "Goblins aggro",
          "format" => "standard",
          "description" => "Deck tornament"
        }
        |> MagicDecks.create_deck()

      response =
        conn
        |> get(Routes.decks_path(conn, :index))
        |> json_response(:ok)

      assert [
               %{"name" => "Fractius aggro"},
               %{"name" => "Goblins aggro"}
             ] = response
    end

    test "filters decks by format, when receive format path param", %{conn: conn} do
      {:ok, _} =
        %{
          "name" => "Fractius aggro",
          "format" => :standard,
          "description" => "Deck forfun"
        }
        |> MagicDecks.create_deck()

      {:ok, _} =
        %{
          "name" => "Goblins aggro",
          "format" => :commander,
          "description" => "Deck tornament"
        }
        |> MagicDecks.create_deck()

      response =
        conn
        |> get(Routes.decks_path(conn, :index, %{"format" => "standard"}))
        |> json_response(:ok)

      assert [%{"name" => "Fractius aggro", "format" => "standard"}] = response
    end
  end

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

  describe "#update" do
    test "returns ok, when params are valid", %{conn: conn} do
      {:ok, %Deck{id: deck_id}} =
        %{name: "Fractius", format: :commander, description: "A deck"}
        |> MagicDecks.create_deck()

      params = %{
        "id" => deck_id,
        "name" => "New name",
        "format" => "standard",
        "description" => "Deck for fun"
      }

      response =
        conn
        |> put(Routes.decks_path(conn, :update, deck_id, params))
        |> json_response(:ok)

      assert %{
               "description" => "Deck for fun",
               "format" => "standard",
               "id" => _id,
               "inserted_at" => _inserted_at,
               "name" => "New name"
             } = response
    end

    test "returns not found status, when deck id don't belong to a register", %{conn: conn} do
      fake_id = "9314b4a2-7280-431a-989e-63595cdfaa19"

      params = %{
        "id" => fake_id,
        "name" => "New name",
        "format" => "standard",
        "description" => "Deck for fun"
      }

      response =
        conn
        |> put(Routes.decks_path(conn, :update, fake_id, params))
        |> json_response(:not_found)

      assert response == %{"errors" => ["Deck not found."]}
    end

    test "returns bad_request status, when received id with invalid format", %{conn: conn} do
      invalid_id = "123"

      params = %{
        "id" => invalid_id,
        "name" => "New name",
        "format" => "standard",
        "description" => "Deck for fun"
      }

      response =
        conn
        |> put(Routes.decks_path(conn, :update, invalid_id, params))
        |> json_response(:bad_request)

      assert response == %{"errors" => ["Invalid id format."]}
    end
  end

  describe "#delete" do
    test "deletes deck, when received id is valid", %{conn: conn} do
      {:ok, %Deck{id: deck_id}} =
        %{name: "Goblins", format: :commander, description: "aggro"}
        |> MagicDecks.create_deck()

      before_count = MagicDecks.Repo.aggregate(Deck, :count)

      response = delete(conn, Routes.decks_path(conn, :delete, deck_id))

      after_count = MagicDecks.Repo.aggregate(Deck, :count)

      assert after_count < before_count
      assert response.status == 204
    end

    test "returns bad request status with error message, when id format is invalid", %{conn: conn} do
      response =
        conn
        |> delete(Routes.decks_path(conn, :delete, "123"))
        |> json_response(:bad_request)

      assert %{"errors" => ["Invalid id format."]} == response
    end

    test "returns not found status with error message, when deck don't exist", %{conn: conn} do
      fake_id = "9314b4a2-7280-431a-989e-63595cdfaa19"

      response =
        conn
        |> delete(Routes.decks_path(conn, :delete, fake_id))
        |> json_response(:not_found)

      assert response == %{"errors" => ["Deck not found."]}
    end
  end
end
