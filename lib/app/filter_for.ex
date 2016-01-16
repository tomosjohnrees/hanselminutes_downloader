defmodule FilterFor do
  def file_extension(list, file_extension) do
    list
    |> Enum.filter(fn(url) -> url |> FileExtensionChecker.extension_is(file_extension) end)
  end
end
