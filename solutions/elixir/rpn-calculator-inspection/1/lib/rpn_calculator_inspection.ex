defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid =
      spawn_link(fn ->
        calculator.(input)
      end)

    %{input: input, pid: pid}
  end

  def await_reliability_check_result(check, results) do
    receive do
      {:EXIT, pid, :normal} when pid == check.pid ->
        Map.put(results, check.input, :ok)

      {:EXIT, pid, _reason} when pid == check.pid ->
        Map.put(results, check.input, :error)
    after
      100 ->
        Map.put(results, check.input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    old_flag = Process.flag(:trap_exit, true)

    checks =
      Enum.map(inputs, fn input ->
        start_reliability_check(calculator, input)
      end)

    results =
      Enum.reduce(checks, %{}, fn check, acc ->
        await_reliability_check_result(check, acc)
      end)

    Process.flag(:trap_exit, old_flag)

    results
  end

  def correctness_check(calculator, inputs) do
    tasks =
      Enum.map(inputs, fn input ->
        Task.async(fn ->
          calculator.(input)
        end)
      end)

    Enum.map(tasks, fn task ->
      Task.await(task, 100)
    end)
  end
end
