defmodule FileNameExtractor do
  def extract_name_from_url(url) do
    Regex.run(~r{([^/]*)$$}, url) |> List.first
  end
end
