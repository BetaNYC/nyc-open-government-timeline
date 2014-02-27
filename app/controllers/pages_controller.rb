class PagesController < ApplicationController

  def outline
    @events = Event.all
  end

end
