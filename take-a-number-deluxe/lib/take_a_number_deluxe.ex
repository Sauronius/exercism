defmodule TakeANumberDeluxe do
  use GenServer
  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :dupa)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :jaja)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:pizda, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :skoczek)
  end

  @impl true
  def init(init_arg) do
    min = Keyword.get(init_arg, :min_number)
    max = Keyword.get(init_arg, :max_number)
    auto = Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)
    state = TakeANumberDeluxe.State.new(min, max, auto)
    case state do
      {:error, error} -> {:stop, error}
      _ -> {:ok, elem(state, 1), elem(state, 1).auto_shutdown_timeout}
    end
  end
  @impl true
  def handle_call(:dupa, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end
  @impl true
  def handle_call(:jaja, _from, state) do
    reply = TakeANumberDeluxe.State.queue_new_number(state)
    case reply do
      {:error, _error} -> {:reply, reply, state, state.auto_shutdown_timeout}
      _ -> {:reply, {:ok, elem(reply, 1)}, elem(reply, 2), elem(reply, 2).auto_shutdown_timeout}
    end
  end
  @impl true
  def handle_call({:pizda, priority_number}, _from, state) do
    reply = TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number)
    case reply do
      {:error, _error} -> {:reply, reply, state, state.auto_shutdown_timeout}
      _ -> {:reply, {:ok, elem(reply, 1)}, elem(reply, 2), elem(reply, 2).auto_shutdown_timeout}
    end
  end
  @impl true
  def handle_cast(:skoczek, state) do
    min = state.min_number
    max = state.max_number
    ns = TakeANumberDeluxe.State.new(min, max, state.auto_shutdown_timeout) |> elem(1)
    {:noreply, ns, ns.auto_shutdown_timeout}
  end
  @impl true
  def handle_info(:timeout, _) do
    {:stop, :normal, []}
  end
  @impl true
  def handle_info(_msg, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
