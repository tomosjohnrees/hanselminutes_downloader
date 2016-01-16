defmodule HanselminutesDownloader do
  def main do
    sample = Crawler.find_podcast_urls
    |> Enum.map(fn(podcast_url) ->
      { 
        "#{podcast_url |> FileNameExtractor.extract_name_from_url}",
        podcast_url
      }
    end)

    [a, b, c | _] = sample
    small_sample = [a, b, c]

    small_sample
    |> Enum.map(fn({name, url}) -> {name, url |> Crawler.find_all_urls_on_page} end)
    |> Enum.map(fn({name, urls}) -> {name, urls |> FilterFor.file_extension(:mp3)} end)
    |> Enum.map(fn({name, url}) -> FileSaver.save(name, url) end)
  end
end
