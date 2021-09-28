defmodule TakeANumber do
  def start() do
    spawn(fn -> loop(0) end)
  end

  def loop(state) do
    receive do
      {:report_state, caller} ->
        send(caller, state)
        loop(state)

      {:take_a_number, caller} ->
        send(caller, state + 1)
        loop(state + 1)

      :stop ->
        {:stop}

      _ ->
        loop(state)
    end
  end
end
