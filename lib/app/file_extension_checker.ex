defmodule FileExtensionChecker do
  def extension_is(string, file_extension) when is_bitstring(string) do
    Regex.run(
      ~r{\.#{file_extension}$},
      string)
    |> check
  end
  def extension_is(error, _) do
    raise inspect(error) <> "is not a string"
  end

  defp check([_]),
    do: true
  defp check(nil),
    do: false
end
