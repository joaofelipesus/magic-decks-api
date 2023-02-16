defmodule MagicDecks.ErrorMessages do
  def invalid_uuid_error(), do: "Invalid id format."

  def resource_not_found(resource_name) do
    capitalized_resource_name = resource_name
    |> Atom.to_string()
    |> String.capitalize()

    "#{capitalized_resource_name} not found."
  end
end
