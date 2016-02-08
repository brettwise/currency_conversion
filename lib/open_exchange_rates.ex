defmodule OpenExchangeRates do
  use HTTPoison.Base

  @expected_fields ~w(
    disclaimer licence timestamp base rates
  )

  def process_url(url) do
    "https://openexchangerates.org/" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Dict.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
