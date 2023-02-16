defmodule MagicDecksWeb.DecksController do
  use MagicDecksWeb, :controller

  action_fallback MagicDecksWeb.FallbackController

  def create(conn, %{"name" => name, "format" => format, "description" => description}) do
    %{name: name, format: format, description: description}
    |> MagicDecks.create_deck()
    |> handle_response(conn, "show.json", :created)
  end

  def show(conn, %{"id" => id}) do
    id
    |> MagicDecks.find_deck()
    |> handle_response(conn, "show.json", :ok)
  end

  defp handle_response({:error, _error} = error, _conn, _view, _status), do: error

  defp handle_response({:ok, deck}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, %{deck: deck})
  end
end
