defmodule LogLevel do
  def to_label(level, legacy?) do
    # Please implement the to_label/2 function
    cond do
      level == 0 && legacy? == false ->
        :trace
      level == 1 ->
        :debug
      level == 2 ->
        :info
      level == 3 ->
        :warning
      level == 4 ->
        :error
      level == 5 && legacy? == false ->
        :fatal
      true ->
        :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    # Please implement the alert_recipient/2 function
    cond do
      to_label(level, legacy?) == :error || to_label(level, legacy?) == :fatal ->
        :ops
      to_label(level, legacy?) == :unknown && legacy? == true ->
        :dev1
      to_label(level, legacy?) == :unknown ->
        :dev2
      true ->
        nil
    end
  end
end
