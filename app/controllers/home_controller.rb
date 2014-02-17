class HomeController < ApplicationController
  def index
    @servers = Server.recent
  end
  
end
