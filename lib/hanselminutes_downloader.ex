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

# e.g. filter_for_mp3 [".com/bla/file.mp3", "www.bla.com/about.index"]
#      => [".com/bla/file.mp3"]
  def filter_for_mp3(list) do
    list
    |> Enum.filter(fn(url) -> url |> is_mp3? end)
  end

  def is_mp3?([ "3", "p", "m", "." | _ ]),
    do: true
  def is_mp3?([ _ | _ ]),
    do: false
  def is_mp3?(url) do
    url
    |> String.codepoints
    |> Enum.reverse
    |> is_mp3?
  end

  def extract_mp3_name(url) do
    url
    |> String.codepoints
    |> Enum.reverse
    |> extract_mp3_name([])
  end
  def extract_mp3_name([x, "/" | tail], result) do
    [ x | result ] |> Enum.join
  end
  def extract_mp3_name([x | tail], result) do
    extract_mp3_name(tail, [x | result])
  end

  def save_mp3(url, name) do
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    File.write!( name <> ".mp3", body)
  end
end
