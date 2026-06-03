defmodule NameBadge do
  def print(id, name, department) do
    depart =
      if(is_nil(department)) do
        "OWNER"
      else
        String.upcase(department)
      end
    if is_nil(id) do
      "#{name} - #{depart}"
    else
      "[#{id}] - #{name} - #{depart}"
    end
  end
end
