defmodule CurrencyConversionTest do
  use ExUnit.Case
  doctest CurrencyConversion

  test "Take a string and return a float" do
    assert CurrencyConversion.convert_to_float("1") == 1.0
  end

  test "Provided a number of euros and an exchange rate a rounded amount is returned" do
    assert CurrencyConversion.calculate_result(10, 1.11949) == 11.19
  end
end
