defmodule MagicDecks.Card.Search do
  alias MagicDecks.MagicApi.Client
  alias MagicDecks.{Card, Repo}
  import Ecto.Query, only: [from: 2]

  def call(name, lang: :en, method: :db) do
    from(card in Card,
      where: ilike(card.name_en, ^"%#{name}%")
    )
    |> handle_query()
  end

  def call(name, lang: :pt, method: :db) do
    from(card in Card,
      where: ilike(card.name_pt, ^"%#{name}%")
    )
    |> handle_query()
  end

  def call(name, lang: lang, method: :api), do: Client.find_by_name(name, lang: lang)

  defp handle_query(query), do: {:ok, Repo.all(query)}
end
