defmodule DateParser do
  @spec day :: String.t
  def day() do
    # Please implement the day/0 function
    "(0?[1-9]|[1-2][0-9]|3[0-1])"
  end

  @spec month :: String.t
  def month() do
    # Please implement the month/0 function
    "(0?[1-9]|1[0-2])"
  end

  @spec year :: String.t
  def year() do
    # Please implement the year/0 function
    "\\d{4}"
  end

  @spec day_names :: String.t
  def day_names() do
    # Please implement the day_names/0 function
    "(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)"
  end

  @spec month_names :: String.t
  def month_names() do
    # Please implement the month_names/0 function
    "(January|February|March|April|May|June|July|August|September|October|November|December)"
  end

  @spec capture_day :: String.t
  def capture_day() do
    # Please implement the capture_day/0 function
    "(?<day>#{day()})"
  end

  @spec capture_month :: String.t
  def capture_month() do
    # Please implement the capture_month/0 function
    "(?<month>#{month()})"
  end

  @spec capture_year :: String.t
  def capture_year() do
    # Please implement the capture_year/0 function
    "(?<year>#{year()})"
  end

  @spec capture_day_name :: String.t
  def capture_day_name() do
    # Please implement the capture_day_name/0 function
    "(?<day_name>#{day_names()})"
  end

  @spec capture_month_name :: String.t
  def capture_month_name() do
    # Please implement the capture_month_name/0 function
    "(?<month_name>#{month_names()})"
  end

  @spec capture_numeric_date :: String.t
  def capture_numeric_date() do
    # Please implement the capture_numeric_date/0 function
    "#{capture_day()}/#{capture_month()}/#{capture_year()}"
  end

  @spec capture_month_name_date :: String.t
  def capture_month_name_date() do
    # Please implement the capture_month_name_date/0 function
    "#{capture_month_name()}\\s#{capture_day()},\\s#{capture_year()}"
  end

  @spec capture_day_month_name_date :: String.t
  def capture_day_month_name_date() do
    # Please implement the capture_day_month_name_date/0 function
    "#{capture_day_name()},\\s#{capture_month_name()}\\s#{capture_day()},\\s#{capture_year()}"
  end

  def match_numeric_date() do
    # Please implement the match_numeric_date/0 function
    "^#{capture_numeric_date()}$" |> Regex.compile!()
  end

  def match_month_name_date() do
    # Please implement the match_month_name_day/0 function
    "^#{capture_month_name_date()}$" |> Regex.compile!()
  end

  def match_day_month_name_date() do
    # Please implement the match_day_month_name_date/0 function
    "^#{capture_day_month_name_date()}$" |> Regex.compile!()
  end
end
