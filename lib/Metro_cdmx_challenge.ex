import SweetXml
defmodule MetroCDMXChallenge do

  #aqui es lo del structure que agrega campos al mapa
  defmodule Station do
    defstruct [:name, :coords]
  end



  def metro_lineas do
    {:ok, xmldoc} = File.read(Path.expand("./lib/Metro_CDMX.xml"))
    #coordenada que tiene las lineas
    coordenadas = xmldoc |> xpath(~x"//Document/Folder/Placemark/LineString/coordinates/text()"ls)
    #hace espacios de linea y lo convierte a lista
    |> Enum.map(fn x -> x |> String.trim()|>String.split()end)

    #pide al xpath las lineas
    linea = xmldoc|> xpath(~x"//Document/Folder[1]/Placemark/name/text()"ls)

    #pide al xpath las estaciones
    hola1=xmldoc|> xpath(~x"//Document/Folder[2]/Placemark/name/text()"ls)
    #Coordenada que tien estaciones (pide al xpath las coordenadas)
    hola2=xmldoc|> xpath(~x"//Document/Folder[2]/Placemark/Point/coordinates/text()"ls)

    #quitar espacios blanco (trim)
    |> Enum.map(fn x -> x |> String.trim() end)

    #crea tuplas juntando hola 1(estaciones) y hola 2 (coordenadas) y con eso crea nuevo mapa
    estaciones = Enum.zip(hola2, hola1) |> Map.new


    #junta las "lineas" y "nombre estaciones" (mezcla todo todo)
    Enum.zip(linea, coordenadas) |> Enum.map(fn {linea, coords} -> %Station{name: linea,coords: encuentra_coordenada(estaciones, coords)}  end)


  end

  #encuentra la estacion entera usando la coordenada
  def encuentra_coordenada(estaciones, coordenadas)  do

    Enum.map(coordenadas ,fn x-> %{name: estaciones[x],coords: x} end)

  end

end