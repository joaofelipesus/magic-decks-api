defmodule MagicDecksWeb.DecksController do
  use MagicDecksWeb, :controller
  # TODO: add fallback controller
  # TODO: handle error request

  def create(conn, %{"name" => name, "format" => format, "description" => description}) do
    %{name: name, format: format, description: description}
    |> MagicDecks.create_deck()
    |> handle_response(conn, "show.json", :created)
  end

  defp handle_response({:ok, deck}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, %{deck: deck})
  end
end
