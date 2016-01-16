defmodule Crawler do
  def find_podcast_urls do
    HTTPoison.get!("http://hanselminutes.com/archives").body
    |> Floki.find(".showCard")
    |> Floki.attribute("href")
    |> Enum.map(fn(path) -> "http://hanselminutes.com" <> path end)
  end
  
  def find_all_urls_on_page(url) do
    HTTPoison.get!(url).body
    |> Floki.find("a")
    |> Floki.attribute("href")
  end
end
