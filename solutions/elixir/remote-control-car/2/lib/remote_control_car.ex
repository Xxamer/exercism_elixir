defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]
  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery}) do
    cond do
      battery > 0 -> "Battery at #{battery}%"
      battery == 0 -> "Battery empty"
    end
  end

  def drive(%RemoteControlCar{} = car) do
    if car.battery_percentage > 0 do
      %RemoteControlCar{
        nickname: car.nickname,
        battery_percentage: car.battery_percentage - 1,
        distance_driven_in_meters: car.distance_driven_in_meters + 20
      }
    else
      %RemoteControlCar{
        nickname: car.nickname,
        battery_percentage: car.battery_percentage,
        distance_driven_in_meters: car.distance_driven_in_meters
      }
    end
  end
end
