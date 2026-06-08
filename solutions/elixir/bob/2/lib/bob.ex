defmodule Bob do
  def hey(input) do
    input = String.trim(to_string(input))

    cond do
      String.upcase(input) == input and String.downcase(input) != input and
      String.ends_with?(input, "?") ->
        "Calm down, I know what I'm doing!"

      String.ends_with?(input, "?") ->
        "Sure."

      String.upcase(input) == input and String.downcase(input) != input ->
        "Whoa, chill out!"

      String.trim(input) == "" ->
        "Fine. Be that way!"

      true ->
        "Whatever."
    end
  end
end
