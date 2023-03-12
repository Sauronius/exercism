defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    ndt = NaiveDateTime.new(year, month, day, hours, minutes, seconds)
              |> elem(1)

    new_ndt = NaiveDateTime.add(ndt, 1_000_000_000)
    new_time = NaiveDateTime.to_time(new_ndt)
    new_date = NaiveDateTime.to_date(new_ndt)
    {{new_date.year, new_date.month, new_date.day}, {new_time.hour, new_time.minute, new_time.second}}
  end
end
