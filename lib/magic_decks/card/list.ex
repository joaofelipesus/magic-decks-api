defmodule MagicDecks.Card.List do
  alias MagicDecks.{Card, Repo}

  import Ecto.Query, only: [from: 2]

  def call do
    query =
      from card in Card,
        order_by: [asc: card.name_en],
        select: card

    cards = Repo.all(query)
    {:ok, cards}
  end
end
