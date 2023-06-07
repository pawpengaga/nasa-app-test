class AgenciesController < ApplicationController
  require "uri"
  require "net/http"
  require "json"

  def index #Creo que aqui solo se pueden poner funciones finales... investigar.
    data = httpRequest('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=2&api_key=tBzJ96m7oLRbNXDguPW8LDW2B9hxASiSdSINUAlG')
    build_web_page(data)
    photos_count(data)
  end

  private

  def httpRequest(url_requested)
    url = URI(url_requested)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.body)
  end

  def build_web_page(hash_respuesta)
    convertHash = hash_respuesta.to_a
    #largoHash = convertHash[0][1].length
            
    photos =     convertHash.flat_map do |o|
                            o[1].flat_map do |w| #Segundo .map para tomar los valores individuales de "img_src"
                                img_src = w["img_src"]
                                img_src.split("\n")
                            end
                        end

    htmlLoad = ""
    htmlLoad += "<h1 class='display-3 pb-3 text-center'>Curiosity Photos</h1>\n"
    htmlLoad += "<hr>\n"                        

    htmlLoad += "<div class='row'>\n"

    photos.each.with_index do |i, v|
        htmlLoad += "\t<img src=\"#{i}\" class='pb-4 col-4'>\n"
    end

    htmlLoad += "</div>\n"

    File.write('.\app\views\agencies\index.html.erb', htmlLoad)
  end

  def photos_count(hash_respuesta)

    # Utilizar map y each_with_index para crear un nuevo hash
    camarasRastreo = hash_respuesta["photos"].map.with_index do |f, i|
    { "Foto #{i + 1}" => f["camera"]["name"] }
    end
    
    fotosxCamara = {} #hash vacio
      
    camarasRastreo.each do |w|
        camarasInd = w.values #Devuelve solo los valores como arrays separados
        fotosxCamara[camarasInd] = camarasRastreo.count { |u| u.values == camarasInd }
    end
    
    puts "Las fotos por cada cámara son: "
    puts fotosxCamara

  end

end
