defmodule MagicDecksWeb.DeckCardsController do
  use MagicDecksWeb, :controller

  action_fallback MagicDecksWeb.FallbackController

  def create(conn, %{"deck_id" => deck_id, "card" => card_params}) do
    card = Map.new(card_params, fn {k, v} -> {String.to_atom(k), v} end)

    %{deck_id: deck_id, card: card}
    |> MagicDecks.create_deck_card()
    |> handle_response(conn, "ok.json", :ok)
  end

  defp handle_response({:error, _error} = error, _conn, _view, _status), do: error

  defp handle_response({:ok, deck_card}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, %{deck_card: deck_card})
  end
end
