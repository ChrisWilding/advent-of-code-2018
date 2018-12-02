defmodule InventoryManagementSystem do
  def run("1", file) do
    {two, three} =
      file
      |> String.split()
      |> Enum.map(&InventoryManagementSystem.count/1)
      |> Enum.reduce({0, 0}, fn list, acc ->
        Enum.reduce(list, acc, fn n, {two, three} ->
          cond do
            n == 2 -> {two + 1, three}
            n == 3 -> {two, three + 1}
          end
        end)
      end)

    two * three
  end

  def run("2", file) do
    ids = file |> String.split()
    [{a, b} | _] = for a <- ids, b <- ids, one_letter_difference(a, b), do: {a, b}

    Enum.zip(String.graphemes(a), String.graphemes(b))
    |> Enum.filter(fn {a, b} -> a == b end)
    |> Enum.map(fn {a, _} -> a end)
    |> Enum.join()
  end

  def count(string) do
    string
    |> String.graphemes()
    |> Enum.reduce(%{}, fn letter, acc -> Map.update(acc, letter, 1, &(&1 + 1)) end)
    |> Enum.filter(fn {_, v} -> v > 1 end)
    |> Enum.group_by(fn {_, v} -> v end)
    |> Enum.map(fn {k, _} -> k end)
  end

  def one_letter_difference(a, b) do
    count =
      Enum.zip(String.graphemes(a), String.graphemes(b))
      |> Enum.count(fn {a, b} -> a == b end)

    count == 25
  end
end

[part, file] = System.argv()
contents = File.read!(file)
output = InventoryManagementSystem.run(part, contents)
IO.puts(output)
