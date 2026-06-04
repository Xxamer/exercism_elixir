defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    for top <- tops, bottom <- bottoms do
      {top, bottom}
    end
    |> Enum.filter(fn {top, bottom} ->
      top.base_color != bottom.base_color
    end)
    |> Enum.filter(fn {top, bottom} ->
      case Keyword.get(options, :maximum_price, 100) do
        nil -> true
        max_price -> top.price + bottom.price <= max_price
      end
    end)
  end
end
