defmodule FreelancerRates do

  def daily_rate(hourly_rate), do: hourly_rate * 8.0


  # Discount for a daily rate
  def apply_discount(before_discount, discount), do: before_discount * (1 - discount / 100)

  def monthly_rate(hourly_rate, discount), do: ceil(apply_discount(daily_rate(hourly_rate) * 22, discount))

  def days_in_budget(budget, hourly_rate, discount) do
    days = budget / apply_discount(daily_rate(hourly_rate), discount)
    Float.floor(days, 1)
  end
end
