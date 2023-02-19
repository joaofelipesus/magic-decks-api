defmodule MagicDecks.Deck.List do
  alias MagicDecks.Repo
  alias MagicDecks.Deck
  import Ecto.Query, only: [from: 2]

  def call do
    query = from d in Deck,
      order_by: [asc: d.name]

    Repo.all(query)
  end

  def call(%{format: format}) do
    query = from d in Deck,
      where: d.format == ^format,
      order_by: [asc: d.name]

    Repo.all(query)
  end
end
