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

  # TODO: add create route
  # TODO: add index route
  # TODO: add delete route
end
