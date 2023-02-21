defmodule MagicDecks.Card do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @attributes [
    :name_en,
    :name_pt,
    :set,
    :set_number,
    :mana_cost,
    :types,
    :rarity,
    :power,
    :toughness,
    :colors,
    :image_url
  ]

  @required [
    :name_en,
    :name_pt,
    :set,
    :set_number,
    :mana_cost,
    :types,
    :rarity
  ]

  schema "cards" do
    field :name_en, :string
    field :name_pt, :string
    field :set, :string
    field :set_number, :integer
    field :rarity, Ecto.Enum, values: [:common, :incommon, :rare, :mythic]
    field :mana_cost, :string
    field :types, {:array, :string}
    field :power, :integer
    field :toughness, :integer
    field :colors, {:array, :string}
    field :image_url, :string
    timestamps()
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)

  def changeset(card, params), do: create_changeset(card, params)

  defp create_changeset(card, params) do
    card
    |> cast(params, @attributes)
    |> validate_required(@required)
  end
end
