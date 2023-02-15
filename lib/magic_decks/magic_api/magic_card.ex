defmodule MagicDecks.MagicApi.MagicCard do
  defstruct [
    :name_en,
    :types,
    :power,
    :toughness,
    :colors,
    :mana_cost,
    :rarity,
    :set,
    :set_number,
    :image_url,
    :name_pt
  ]

  def build(params) do
    %__MODULE__{
      name_en: params["name"],
      types: params["types"],
      power: params["power"],
      toughness: params["toughness"],
      colors: params["colors"],
      mana_cost: params["manaCost"],
      rarity: params["rarity"],
      set: params["setName"],
      set_number: params["number"],
      image_url: params["imageUrl"],
      name_pt: name_pt(params)
    }
  end

  defp name_pt(%{"foreignNames" => foreign_names}) do
    brazilian_card =
      foreign_names
      |> Enum.find(fn foreign_name -> foreign_name["language"] == "Portuguese (Brazil)" end)

    brazilian_card["name"]
  end
end