defmodule HanselminutesDownloader do
  def find_podcast_urls do
    %HTTPoison.Response{body: body} = HTTPoison.get!("http://hanselminutes.com/archives")
    body
    |> Floki.find(".showCard")
    |> Floki.attribute("href")
    |> Enum.map(fn(path) -> "http://hanselminutes.com" <> path end)
  end

  def find_all_urls(url) do
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    body
    |> Floki.find("a")
    |> Floki.attribute("href")
  end
end
