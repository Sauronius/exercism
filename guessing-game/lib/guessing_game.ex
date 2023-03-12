defmodule GuessingGame do
  def compare(secret_number, guess \\ nil) do
    # Please implement the compare/2 function
    cond do
      is_integer(guess) == false ->
        "Make a guess"
      secret_number === guess ->
        "Correct"
      abs(secret_number - guess) === 1 ->
        "So close"
      secret_number < guess ->
        "Too high"
      secret_number > guess ->
        "Too low"
    end
  end
end
