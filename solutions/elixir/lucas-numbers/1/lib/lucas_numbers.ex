defmodule LucasNumbers do
  def generate(count) when is_integer(count) and count >= 1, do: do_generate(count)
  def generate(_count), do: raise(ArgumentError, "count must be specified as an integer >= 1")
  defp do_generate(1), do: [2]
  defp do_generate(2), do: [2, 1]

  defp do_generate(count) do
    Stream.iterate({2, 1}, fn {a, b} -> {b, a + b} end)
    |> Stream.map(fn {a, _b} -> a end)
    |> Enum.take(count)
  end
end
