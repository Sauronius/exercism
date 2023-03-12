defmodule TakeANumber do
  @spec start :: pid
  def start() do
    Kernel.spawn(fn -> machine(0) end)
  end

  defp machine(current_state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, current_state)
        machine(current_state)
      {:take_a_number, sender_pid} ->
        state = current_state + 1
        send(sender_pid, state)
        machine(state)
      :stop -> nil
      _ -> machine(current_state)
    end
  end
end
