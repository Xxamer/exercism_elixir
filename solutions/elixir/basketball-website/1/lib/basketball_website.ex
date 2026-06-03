defmodule BasketballWebsite do
  defp make_extract_from_path(nil, _), do: nil
  defp make_extract_from_path(data, []), do: data
  defp make_extract_from_path(data, [initial_path | tail]) do
    make_extract_from_path(data[initial_path], tail)
  end
  def extract_from_path(data, path) do
    make_extract_from_path(data, String.split(path, "."))
  end

  def get_in_path(data, path) do
    splitted_path = String.split(path, ".")
    get_in(data, splitted_path)
  end
end
