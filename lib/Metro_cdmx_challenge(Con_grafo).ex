import SweetXml
defmodule MetroCDMXChallenge do

  #aqui es lo del structure que agrega campos al mapa
  defmodule Station do
    defstruct [:name, :coords]
  end
  defmodule Line do
    defstruct [:name, :stations]
  end



  def metro_lineas(xmlpath) do
    xmldoc = File.read!(xmlpath)
    #coordenada que tiene las lineas
    coordenadas = xmldoc |> xpath(~x"//Document/Folder/Placemark/LineString/coordinates/text()"ls)
    #hace espacios de linea y lo convierte a lista
    |> Enum.map(fn x -> x |> String.trim()|>String.split()end)

    #pide al xpath las lineas
    linea = xmldoc|> xpath(~x"//Document/Folder[1]/Placemark/name/text()"ls)

    #pide al xpath las "estaciones"
    hola1=xmldoc|> xpath(~x"//Document/Folder[2]/Placemark/name/text()"ls)
    #Coordenada que tiene estaciones (pide al xpath las coordenadas)
    hola2=xmldoc|> xpath(~x"//Document/Folder[2]/Placemark/Point/coordinates/text()"ls)

    #quitar espacios blanco (trim)
    |> Enum.map(fn x -> x |> String.trim() end)

    #crea tuplas juntando hola 1(estaciones) y hola 2 (coordenadas) y con eso crea nuevo mapa
    estaciones = Enum.zip(hola2, hola1) |> Map.new


    #junta las "lineas" y "nombre estaciones" (mezcla todo todo)
    Enum.zip(linea, coordenadas) |> Enum.map(fn {linea, coords} -> %Line{name: linea, stations: encuentra_coordenada(estaciones, coords)}  end)


  end

  #encuentra la estacion entera usando la coordenada
  def encuentra_coordenada(estaciones, coordenadas)  do

    Enum.map(coordenadas ,fn x-> %Station{name: estaciones[x],coords: x} end)

  end

  def metro_graph(xmlpath) do
    m_lines = metro_lineas(xmlpath)
    graph = Graph.new(type: :undirected)

    Enum.reduce(m_lines, graph, fn line, graph ->
      st = Enum.chunk_every(line.stations, 2, 1, :discard)
      Enum.reduce(st, graph, fn stations, graph ->
        Graph.add_edge(graph, List.first(stations).name, List.last(stations).name)

      end)
    end)
  end
end



#cd ./Escritorio/becarios_bunsan_2022_b1
#iex -S mix
# r MetroCDMXChallenge
#MetroCDMXChallenge.metro_lineas() (antes usaba este)

#MetroCDMXChallenge.metro_lineas("./lib/Metro_CDMX.xml") (ahora se usa este para ejecutarlo)
#MetroCDMXChallenge.metro_graph("./lib/Metro_CDMX.xml") (con este se ejecuta el graph)

