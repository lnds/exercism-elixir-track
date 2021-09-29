defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      NaiveDateTime.to_date(checkout_datetime) |> Date.add(28)
    else
      NaiveDateTime.to_date(checkout_datetime) |> Date.add(29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    d = Date.diff(actual_return_datetime, planned_return_date)

    if d < 0 do
      0
    else
      d
    end
  end

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime) |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_date = datetime_from_string(checkout)
    return_date = datetime_from_string(return)
    planned_return_date = return_date(checkout_date)
    late = days_late(planned_return_date, return_date)

    if monday?(return_date) do
      div(late * rate, 2)
    else
      late * rate
    end
  end
end
