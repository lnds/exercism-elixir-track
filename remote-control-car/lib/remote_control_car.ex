defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:battery_percentage, :distance_driven_in_meters, :nickname]

  def new(nickname \\ "none") do
    %RemoteControlCar{
      battery_percentage: 100,
      distance_driven_in_meters: 0,
      nickname: nickname
    }
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: m}) do
    "#{m} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"
  def display_battery(%RemoteControlCar{battery_percentage: b}), do: "Battery at #{b}%"

  def drive(%RemoteControlCar{distance_driven_in_meters: d, battery_percentage: b} = remote_car)  do
    if b > 0 do
      %RemoteControlCar{remote_car| distance_driven_in_meters: d+20, battery_percentage: b-1 }
    else
      remote_car
    end
   end

end
