defmodule NameBadge do
  @spec print(integer(), String.t(), String.t()) :: String.t()
  def print(id, name, department) do
    if department do
      if id do
        "[#{id}] - #{name} - #{String.upcase(department)}"
      else
        "#{name} - #{String.upcase(department)}"
      end
    else
      if id do
        "[#{id}] - #{name} - OWNER"
      else
        "#{name} - OWNER"
      end
    end
  end
end
