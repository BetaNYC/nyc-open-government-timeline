class PagesController < ApplicationController

  def outline
    @events = Event.all
  end

  def home
  end
  

end
