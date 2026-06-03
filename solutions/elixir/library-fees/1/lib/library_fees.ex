defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      Date.add(checkout_datetime, 28)
    else
      Date.add(checkout_datetime, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    if Date.compare(planned_return_date, actual_return_datetime) == :lt do
      Date.diff(actual_return_datetime, planned_return_date)
    else
      0
    end
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  @spec calculate_late_fee(binary(), binary(), number()) :: number()
  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = return_date(datetime_from_string(checkout))
    return_datetime = datetime_from_string(return)
    days_late = days_late(checkout_datetime, return_datetime)
    if monday?(return_datetime) do
     trunc(days_late * rate * 0.5)
    else
      days_late * rate
    end
  end
end
