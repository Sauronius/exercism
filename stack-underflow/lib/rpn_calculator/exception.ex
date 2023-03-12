defmodule RPNCalculator.Exception do

  # Please implement DivisionByZeroError here.
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  # Please implement StackUnderflowError here.
  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"
    @impl true
    def exception(value) do
      case value do
        [] ->
          msg = "stack underflow occurred"
          %StackUnderflowError{message: msg}
        _ ->
          msg = "stack underflow occurred, context: " <> "#{value}"
          %StackUnderflowError{message: msg}
      end
    end
  end

  def divide([]), do: raise StackUnderflowError, "when dividing"
  def divide([_]), do: raise StackUnderflowError, "when dividing"
  def divide([0, _]), do: raise DivisionByZeroError
  def divide([a, b]), do: b/a
end
