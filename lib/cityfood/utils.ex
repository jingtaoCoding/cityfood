defmodule CityFood.Utils do
  def compact(nil), do: nil

  def compact(map) when is_map(map) do
    map
    |> Enum.reject(fn {_key, value} -> nil_or_empty?(value) end)
    |> Map.new()
  end

  def nil_or_empty?(nil), do: true
  def nil_or_empty?(variable) when is_binary(variable), do: String.trim(variable) == ""
  def nil_or_empty?(variable) when is_list(variable), do: variable == []
  def nil_or_empty?(variable) when is_map(variable), do: variable == %{}
  def nil_or_empty?(variable) when is_tuple(variable), do: variable == {}
  def nil_or_empty?(_), do: false

  def atom_map(map) when is_map(map) do
    map
    |> Enum.map(fn {key, val} -> {String.to_existing_atom(key), val} end)
    |> Map.new()
  end
end
