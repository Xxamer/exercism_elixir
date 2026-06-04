defmodule RPNCalculator do
  @doc """
  Stack is array and operation is a function that takes
  the stack as an argument and performs some operation on it.
  The calculate!/2 function should return the result of the operation,
  and if the operation raises an error, it should let it crash.
  """
  def calculate!(stack, operation), do: operation.(stack)
  def calculate(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      e -> {:error, Exception.message(e)}
    end
  end
end
