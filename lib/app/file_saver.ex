defmodule FileSaver do
  def save(name, url) do
    IO.puts "Saving #{name}.mp3"
    
    case HTTPoison.get!(url) do
      %HTTPoison.Response{status_code: 200, body: data} ->
        File.write!( "#{name}.mp3", data)
        IO.puts "success"
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "#{url} not found"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
end
