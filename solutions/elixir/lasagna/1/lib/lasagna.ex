defmodule Lasagna do

  @spec expected_minutes_in_oven() :: 40
  def expected_minutes_in_oven do
    40
  end

  def remaining_minutes_in_oven(minutes_in_oven) do
    Lasagna.expected_minutes_in_oven - minutes_in_oven
  end

  def preparation_time_in_minutes(number_of_layers) do
    number_of_layers * 2
  end

  @spec total_time_in_minutes(number(), number()) :: number()
  def total_time_in_minutes(number_of_layers, minutes_in_oven) do
    preparation_time_in_minutes(number_of_layers) + minutes_in_oven
  end

  def alarm do
    "Ding!"
  end
end
