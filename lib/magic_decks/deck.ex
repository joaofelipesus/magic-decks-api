defmodule MagicDecks.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @required [:name, :format]

  schema "decks" do
    field :name, :string
    field :description, :string
    field :format, Ecto.Enum, values: [:commander, :modern, :standard]
    timestamps()
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)

  def changeset(deck, params), do: create_changeset(deck, params)

  defp create_changeset(deck, params) do
    deck
    |> cast(params, [:name, :format, :description])
    |> validate_required(@required)
    |> unique_constraint([:name, :format], name: :decks_unique_name_and_format_index)
  end
end
