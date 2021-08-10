defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    case planet do
      :mercury -> years_in_planet(0.2408467, seconds)
      :venus -> years_in_planet(0.61519726, seconds)
      :earth -> years_in_planet(1.0, seconds)
      :mars -> years_in_planet(1.8808158, seconds)
      :jupiter -> years_in_planet(11.862615, seconds)
      :saturn -> years_in_planet(29.447498, seconds)
      :uranus -> years_in_planet(84.016846, seconds)
      :neptune -> years_in_planet(164.79132, seconds)
    end
  end

  defp years_in_planet(factor, seconds) do
    year_in_seconds = 31_557_600.0 * factor
    seconds / year_in_seconds
  end
end
