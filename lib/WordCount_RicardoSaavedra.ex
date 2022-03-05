defmodule WordCount do
  def count() do
    {:ok, text} = File.read("./Escritorio/Bunsan-Elixir/hola.txt") #read the file xd
    text=String.replace(text,"á","a") #replace "á" with "a"
    text1=String.split(text) #Can split a string into multiple strings given a patterns (can be a list for example)

    Enum.frequencies(text1) # Return a map with keys as unique element of enumerable and values as the count of every element

  end

end

WordCount.count()
