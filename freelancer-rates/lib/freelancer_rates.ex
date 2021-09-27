defmodule FreelancerRates do
  @factor 8.0
  def daily_rate(hourly_rate) do
    hourly_rate * @factor
  end

  def apply_discount(before_discount, discount) do
    before_discount - before_discount * discount / 100.0
  end

  @days_per_month 22
  def monthly_rate(hourly_rate, discount) do
    (@days_per_month * daily_rate(hourly_rate)) |> apply_discount(discount) |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    rate = daily_rate(hourly_rate) |> apply_discount(discount)
    Float.floor(budget / rate, 1)
  end
end
