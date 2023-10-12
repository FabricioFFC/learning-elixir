defmodule ImportService.Statistics do
  use Agent

  def start_link(opts) do
    Agent.start_link(
      fn ->
        %{accepted_count: 0, discarded_count: 0, started_at: :os.system_time(:millisecond)}
      end,
      opts
    )
  end

  def get_statistics(agent) do
    %{
      accepted_count: get_accepted_count(agent),
      discarded_count: get_discarded_count(agent),
      elapsed_time: get_elapsed_time(agent)
    }
  end

  def increment_accepted_count(agent) do
    Agent.update(agent, fn state ->
      %{state | accepted_count: state.accepted_count + 1}
    end)
  end

  def get_accepted_count(agent) do
    Agent.get(agent, fn state -> state.accepted_count end)
  end

  def increment_discarded_count(agent) do
    Agent.update(agent, fn state ->
      %{state | discarded_count: state.discarded_count + 1}
    end)
  end

  def get_discarded_count(agent) do
    Agent.get(agent, fn state -> state.discarded_count end)
  end

  def get_elapsed_time(agent) do
    Agent.get(agent, fn state ->
      :os.system_time(:millisecond) - state.started_at
    end)
  end
end
