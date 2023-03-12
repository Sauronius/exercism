defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start_link(fn -> %{p_list: [], state_id_n: 1} end, opts)
  end

  def list_registrations(pid) do
    pid
    |> Agent.get(fn state -> Map.get(state, :p_list) end)
  end

  def register(pid, register_to) do
    pid
    |> Agent.get_and_update(fn state ->
        list = Map.values(state)
        new_plot = %Plot{plot_id: List.last(list), registered_to: register_to}
        new_p_list = List.first(list) ++ [new_plot]
        new_state_id_n = List.last(list) + 1
        {new_plot, %{state | p_list: new_p_list, state_id_n: new_state_id_n}}
      end)
  end

  def release(pid, plot_id) do
    pid
    |> Agent.update(fn state -> list = Map.values(state)
      n_list = Enum.reject(List.first(list), fn element -> element.plot_id == plot_id end)
      %{state | p_list: n_list, state_id_n: List.last(list)} end)
  end

  def get_registration(pid, plot_id) do
    pid
    |> Agent.get(fn state ->
      list = Map.values(state)
      Enum.find(List.first(list), {:not_found, "plot is unregistered"}, fn element -> element.plot_id == plot_id end)
       end)
  end
end
