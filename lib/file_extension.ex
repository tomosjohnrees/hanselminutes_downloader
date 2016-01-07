defmodule FileExtension do
  def is(string, file_extension) when is_bitstring(string) do
    Regex.run(
      ~r{\.#{file_extension}$},
      string)
    |> result
  end
  def is(error, _) do
  	raise inspect(error) <> "is not a string"
  end
  defp result([_]),
    do: true

  defp result(nil),
    do: false
end
