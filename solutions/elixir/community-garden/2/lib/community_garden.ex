# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(_opts \\ []) do
    Agent.start(fn -> %{last_id: 0, plots: []} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      next_id = state.last_id + 1
      plot = %Plot{plot_id: next_id, registered_to: register_to}

      {plot,
       %{
         plots: [plot | state.plots],
         last_id: next_id
       }}
    end)
  end

  def release(pid, plot_id) do
    Agent.cast(pid, fn state ->
      delete_plot = Enum.filter(state.plots, fn plot -> plot.plot_id != plot_id end)
      %{state | plots: delete_plot}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      Enum.find(state.plots, fn plot -> plot.plot_id == plot_id end)
      || {:not_found, "plot is unregistered"}
    end)
  end
end
