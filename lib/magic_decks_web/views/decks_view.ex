defmodule MagicDecksWeb.DecksView do
  use MagicDecksWeb, :view

  def render("show.json", %{deck: deck}) do
    %{
      id: deck.id,
      name: deck.name,
      format: deck.format,
      description: deck.description,
      inserted_at: deck.inserted_at
    }
  end
end
