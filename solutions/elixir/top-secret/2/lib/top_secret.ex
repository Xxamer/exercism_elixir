defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {def_type, _, [{:when, _, [{name, _, args} | _]} | _]}
      when def_type in [:def, :defp] ->
        {ast, [separate(name, args) | acc]}

      {def_type, _, [{name, _, args} | _]}
      when def_type in [:def, :defp] ->
        {ast, [separate(name, args) | acc]}

      _ ->
        {ast, acc}
    end
  end

  def decode_secret_message(string) do
    {_, parts} =
      string
      |> to_ast()
      |> Macro.prewalk([],
        fn ast, acc -> decode_secret_message_part(ast, acc)
      end)

    parts |> Enum.reverse() |> Enum.join()
  end

  defp separate(name, args) do
    arity = length(args || [])
    String.slice(Atom.to_string(name), 0, arity)
  end
end
