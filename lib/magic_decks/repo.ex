defmodule MagicDecks.Repo do
  use Ecto.Repo,
    otp_app: :magic_decks,
    adapter: Ecto.Adapters.Postgres
end
