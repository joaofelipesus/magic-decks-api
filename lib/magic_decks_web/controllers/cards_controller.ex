defmodule MagicDecksWeb.CardsController do
  use MagicDecksWeb, :controller

  action_fallback MagicDecksWeb.FallbackController

  def search(conn, %{"name" => name, "lang" => lang, "method" => method}) do
    {:ok, cards} =
      MagicDecks.Card.Search.call(
        name,
        lang: String.to_atom(lang),
        method: String.to_atom(method)
      )

    conn
    |> put_status(:ok)
    |> render("index.json", %{cards: cards})
  end

  def create(conn, params) do
    %{
      image_url: params["image_url"],
      mana_cost: params["mana_cost"],
      name_en: params["name_en"],
      name_pt: params["name_pt"],
      power: params["power"],
      rarity: params["rarity"],
      set: params["set"],
      set_number: params["set_number"],
      toughness: params["toughness"],
      types: params["types"],
      colors: params["colors"]
    }
    |> MagicDecks.create_card()
    |> handle_response(conn, "show.json", :created)
  end

  defp handle_response({:error, _changeset} = error, _conn, _template, _status), do: error

  defp handle_response({:ok, card}, conn, template, status) do
    conn
    |> put_status(status)
    |> render(template, %{card: card})
  end

  # TODO: add create route
  # TODO: add index route
  # TODO: add delete route
end
