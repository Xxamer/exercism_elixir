defmodule TakeANumber do
  defp loop(state \\ 0) do
    receive do
      :stop ->
        nil
      {:report_state, sender_pid} ->
       send(sender_pid, state)
        loop(state)

      {:take_a_number, sender_pid} ->
        add_state = state + 1
        send(sender_pid, add_state)
        loop((add_state))
      # Anything that does not match
      _ -> loop(state)
    end
  end

  @spec start() :: pid()
  def start() do
    # Define the new process
     spawn(fn -> loop() end)
  end
end
