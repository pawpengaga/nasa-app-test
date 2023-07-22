class PagesController < ApplicationController
  require 'api'
  def index
    

  end

  def about
    @myinput = session[:myinput]

    myapi = Api.new(@myinput)
    @pearl = myapi.result()
  end

  def ups
  end

  def my_create
    @myinput = params[:myinput]
    session[:myinput] = @myinput
    redirect_to pages_about_path
  end
  
end
