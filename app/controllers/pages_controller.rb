class PagesController < ApplicationController
  require 'api'
  def index
    

  end

  def about
    @myinput = session[:myinput]

    myapi = Api.new("https://www.omdbapi.com/?i=#{@myinput}&apikey=d089b4eb")
    @result = myapi.result()

    @moviedata = @result.slice("Title", "Year", "Rated", "Genre", "Director", "Writer", "Actors", "Plot", "Poster")

    #Hacer un segundo hash que sean sólo las traducciones y luego como ambos miden lo mismo
    #ponerlo por la cara en el each porque total ambos tienen el mismo index, donde podría ir uno, irá este.
    @traducciones = {
      "Title" => "Título",
      "Year" => "Año",
      "Rated" => "Clasificación",
      "Genre" => "Género",
      "Director" => "Director",
      "Writer" => "Escritores",
      "Actors" => "Actores",
      "Plot" => "Trama",
      "Poster" => "Póster"
    }
  end

  def ups
  end

  def my_create
    @myinput = params[:myinput]
    session[:myinput] = @myinput
    redirect_to pages_about_path
  end
  
end
