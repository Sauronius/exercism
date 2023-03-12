defmodule CustomAssembler do
  @spec run_program(String.t()) :: [String.t()]
  def run_program(program_code) do
    program_code
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, " ") end)
    |> Enum.with_index(fn element, index -> {index, element} end)
    |> single_instruction([0, 0, 0], 0)
  end

  @spec single_instruction([tuple()], list(), integer()) :: [String.t()]
  def single_instruction(instruction_set, [a, b, c] = state, to_execute) do
    instruction =
      instruction_set
      |> Enum.find({2, :error}, fn {x, _y} -> x == to_execute end)

    case elem(instruction, 1) do
      ["ADD"] -> single_instruction(instruction_set, [a, b, a + b], to_execute + 1)
      ["MOV", "A", "B"] -> single_instruction(instruction_set, [b, b, c], to_execute + 1)
      ["MOV", "A", "C"] -> single_instruction(instruction_set, [c, b, c], to_execute + 1)
      ["MOV", "B", "A"] -> single_instruction(instruction_set, [a, a, c], to_execute + 1)
      ["MOV", "B", "C"] -> single_instruction(instruction_set, [a, c, c], to_execute + 1)
      ["MOV", "C", "A"] -> single_instruction(instruction_set, [a, b, a], to_execute + 1)
      ["MOV", "C", "B"] -> single_instruction(instruction_set, [a, b, b], to_execute + 1)
      ["MOV", "A", x] -> single_instruction(instruction_set, [String.to_integer(x), b, c], to_execute + 1)
      ["MOV", "B", x] -> single_instruction(instruction_set, [a, String.to_integer(x), c], to_execute + 1)
      ["MOV", "C", x] -> single_instruction(instruction_set, [a, b, String.to_integer(x)], to_execute + 1)
      ["MUL"] -> single_instruction(instruction_set, [a, b, a * b], to_execute + 1)
      ["JMP", x] -> single_instruction(instruction_set, state, String.to_integer(x))
      ["JNZ", x] -> if(c == 0) do
          single_instruction(instruction_set, state, to_execute + 1)
        else
          single_instruction(instruction_set, state, String.to_integer(x))
        end
      :error -> state
        |> Enum.map(&Integer.to_string(&1, 10))
    end
  end
end
