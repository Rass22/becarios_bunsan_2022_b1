defmodule WordCount do
  def count() do
    {:ok, text} = File.read("./Escritorio/Bunsan-Elixir/hola.txt")
    text1=String.split(text)
    Enum.frequencies(text1)

  end

end

WordCount.count("./Escritorio/Bunsan-Elixir/hola.txt")