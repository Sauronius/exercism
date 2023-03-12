defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer
  @callback init(opts :: opts()) :: {:ok, opts :: opts()} | {:error, error :: error()}
  @callback handle_frame(dot :: dot(), fnumber :: frame_number(), opts :: opts()) :: dot :: dot()
  defmacro __using__(_opts) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts) do
        {:ok, opts}
      end
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation
  def handle_frame(dot, fnumber, _opts) do
    if rem(fnumber, 4) === 0 do
    %{dot | opacity: Map.get(dot, :opacity)/2}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation
  def init(opts) do
    val = opts
    |> Keyword.get(:velocity)
    case is_number(val) do
      true -> {:ok, opts}
      false -> {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(val)}"}
    end
  end
  def handle_frame(dot, fnumber, opts) do
    vel = Keyword.get(opts, :velocity)
    addon = (fnumber - 1) * vel
    %{dot | radius: Map.get(dot, :radius) + addon}
  end
end
