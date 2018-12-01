defmodule ChronalCalibration do
  def run("1", file) do
    file
    |> String.split()
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {n, _} -> n end)
    |> Enum.reduce(&(&1 + &2))
  end

  def run("2", file) do
    frequencies =
      file
      |> String.split()
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(fn {n, _} -> n end)

    find_repeated_frequency(frequencies)
  end

  def find_repeated_frequency([frequency | frequencies] = original) do
    find_repeated_frequency(original, frequencies, MapSet.new(), frequency)
  end

  def find_repeated_frequency(original, [], set, current) do
    find_repeated_frequency(original, original, set, current)
  end

  def find_repeated_frequency(original, [frequency | frequencies], set, current) do
    next = current + frequency

    if MapSet.member?(set, next) do
      next
    else
      find_repeated_frequency(original, frequencies, MapSet.put(set, next), next)
    end
  end
end

[part, file] = System.argv()
contents = File.read!(file)
output = ChronalCalibration.run(part, contents)
IO.puts(output)
