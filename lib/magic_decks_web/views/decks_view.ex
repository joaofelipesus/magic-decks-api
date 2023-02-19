defmodule MagicDecksWeb.DecksView do
  use MagicDecksWeb, :view

  def render("index.json", %{decks: decks}) do
    Enum.map(decks, fn deck ->
      build_deck(deck)
    end)
  end

  def render("show.json", %{deck: deck}) do
    %{
      id: deck.id,
      name: deck.name,
      format: deck.format,
      description: deck.description,
      inserted_at: deck.inserted_at
    }
  end

  defp build_deck(deck) do
    %{
      id: deck.id,
      name: deck.name,
      format: deck.format,
      description: deck.description,
      inserted_at: deck.inserted_at
    }
  end
end
