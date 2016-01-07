defmodule HanselminutesDownloader do
  def main do
    sample = find_podcast_urls
    |> k_v_pair_name_url

    [a,b | _] = sample
    small_sample = [a,b]

    small_sample
    |> Enum.map(fn({name, url}) -> {name, url |> find_all_urls} end)
    |> Enum.map(fn({name, urls}) -> {name, urls |> filter_for_mp3} end)
    |> Enum.map(fn({name, url}) -> save_mp3(name, url) end)
  end

  defp find_podcast_urls do
    HTTPoison.get!("http://hanselminutes.com/archives").body
    |> Floki.find(".showCard")
    |> Floki.attribute("href")
    |> Enum.map(fn(path) -> "http://hanselminutes.com" <> path end)
  end

  defp k_v_pair_name_url(urls) do
    urls
    |> Enum.map(fn(podcast_url) ->
      { "#{podcast_url |> extract_podcast_name}", podcast_url }
    end)
  end

  defp find_all_urls(url) do
    HTTPoison.get!(url).body
    |> Floki.find("a")
    |> Floki.attribute("href")
  end

  defp filter_for_mp3(list) do
    list
    |> Enum.filter(fn(url) -> url |> FileExtension.is :mp3 end)
  end

  defp extract_podcast_name(url) do
    url
    |> String.codepoints
    |> Enum.reverse
    |> extract_podcast_name([])
  end
  defp extract_podcast_name([x, "/" | _], result) do
    [ x | result ] |> Enum.join
  end
  defp extract_podcast_name([x | tail], result) do
    extract_podcast_name(tail, [x | result])
  end

  defp save_mp3(name, url) do
    IO.puts "saving #{name}.mp3"
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    File.write!( "#{name}.mp3", body)
  end
end
