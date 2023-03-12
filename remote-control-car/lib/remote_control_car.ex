defmodule RemoteControlCar do
  @enforce_keys [:nickname]

  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]
  @type t :: %__MODULE__{nickname: String.t(), battery_percentage: non_neg_integer(), distance_driven_in_meters: non_neg_integer()}

  @spec new() :: RemoteControlCar.t()
  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  @spec new(String.t()) :: RemoteControlCar.t()
  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  @spec display_distance(RemoteControlCar.t()) :: String.t()
  def display_distance(remote_car = %RemoteControlCar{}) do
    remote_car.distance_driven_in_meters
    |> to_string()
    |> Kernel.<>(" meters")
  end

  @spec display_battery(RemoteControlCar.t()) :: String.t()
  def display_battery(remote_car = %RemoteControlCar{}) do
    if (remote_car.battery_percentage === 0) do
      "Battery empty"
    else
      remote_car.battery_percentage
      |> to_string()
      |> then(&"Battery at #{&1}%")
    end
  end

  @spec drive(RemoteControlCar.t()) :: RemoteControlCar.t()
  def drive(remote_car = %RemoteControlCar{}) do
    if (remote_car.battery_percentage === 0) do
      remote_car
    else
      %RemoteControlCar{remote_car | battery_percentage: remote_car.battery_percentage - 1, distance_driven_in_meters: remote_car.distance_driven_in_meters + 20}
    end
  end
end
