defmodule LibraryFees do
  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  @spec before_noon?(NaiveDateTime.t()) :: boolean()
  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(~T[12:00:00]) == :lt
  end

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    if(before_noon?(checkout_datetime)) do
      checkout_datetime
      |> NaiveDateTime.to_date()
      |> Date.add(28)
    else
      checkout_datetime
      |> NaiveDateTime.to_date()
      |> Date.add(29)
    end
  end

  @spec days_late(Date.t(), NaiveDateTime.t()) :: non_neg_integer()
  def days_late(planned_return_date, actual_return_datetime) do
    if (Date.compare(planned_return_date, actual_return_datetime) == :lt) do
      actual_return_datetime
      |> NaiveDateTime.to_date()
      |> Date.diff(planned_return_date)
    else
      0
    end
  end

  @spec monday?(NaiveDateTime.t()) :: boolean()
  def monday?(datetime) do
    datetime
    |> Date.day_of_week() === 1
  end

  @spec calculate_late_fee(String.t(), String.t(), non_neg_integer()) :: non_neg_integer()
  def calculate_late_fee(checkout, return, rate) do
    planned_return = checkout
    |> datetime_from_string()
    |> return_date()

    actual_return = return
    |> datetime_from_string()
    if(monday?(actual_return)) do
      days_late(planned_return, actual_return) * rate |> div(2)
    else
      days_late(planned_return, actual_return) * rate
    end
  end
end
