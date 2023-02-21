defmodule MagicDecks.MagicApi.Client do
  use Tesla
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.BaseUrl, "https://api.magicthegathering.io/v1"

  def find_by_name(name, lang: :pt) do
    get("/cards?name=#{name_param(name)}&language=#{pt_language()}")
    |> handle_response()
  end

  def find_by_name(name, lang: :en) do
    get("/cards?name=#{name_param(name)}")
    |> handle_response()
  end

  defp handle_response({:error, _response} = error), do: error

  defp handle_response({:ok, response}) do
    cards = response.body["cards"]
    |> Enum.map(fn card_params -> MagicDecks.MagicApi.MagicCard.build(card_params) end)

    {:ok, cards}
  end

  defp name_param(name), do: URI.encode(name)

  defp pt_language(), do: URI.encode("Portuguese (Brazil)")
end
