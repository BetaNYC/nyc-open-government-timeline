class PagesController < ApplicationController

  def timeline
    
  end

  def outline
    @events = Event.all
  end

end
