defmodule MagicDecksWeb.FallbackController do
  use MagicDecksWeb, :controller

  def call(conn, {:error, %{message: message, code: 404}}) do
    conn
    |> put_status(:not_found)
    |> put_view(MagicDecksWeb.ErrorView)
    |> render("404.json", %{message: message})
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(MagicDecksWeb.ErrorView)
    |> render("400.json", %{result: result})
  end
end
