defmodule ChronalCalibration do
  def run(file) do
    file
    |> String.split()
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {n, _} -> n end)
    |> Enum.reduce(&(&1 + &2))
  end
end

System.argv()
|> File.read!()
|> ChronalCalibration.run()
|> IO.puts()
