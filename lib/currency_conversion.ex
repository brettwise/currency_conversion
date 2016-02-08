defmodule CurrencyConversion do

  def main do
    euros =
      get_euros
      |> convert_to_float

    exchange_rate =
      get_exchange_rate

    calculate_result(euros, exchange_rate)
    |> print_results(euros, exchange_rate)
  end

  def get_euros do
    IO.gets "How many euros are you exchanging? "
  end

  def get_exchange_rate do
    IO.puts "Getting current rates from Open Exchange Rates..."
    OpenExchangeRates.start
    map = OpenExchangeRates.get!("api/latest.json?app_id=" <> System.get_env "OPENEXCHANGERATES").body[:rates]
    1/map["EUR"]
  end

  def convert_to_float(string) do
    try do
      {float, _} = Float.parse(string)
      float
    rescue
      _ ->
        IO.puts "Whoa dude. Looks like that wasn't a number."
        main
    end
  end

  def calculate_result(euros, exchange_rate) do
    euros * exchange_rate
    |> Float.round(2)
  end

  def print_results(total_back, euros, exchange_rate) do
    IO.puts "#{euros} euros at an exchange rate of #{exchange_rate} is $#{total_back} U.S. dollars."
  end
end
