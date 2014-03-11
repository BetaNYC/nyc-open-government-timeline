class PagesController < ApplicationController

  def outline
    @events = Event.all
  end

  def home
  end
  
  def timeline_json
    @timeline = Timeline.new({name: "BetaNYC Open Government Timeline", intro: "This is a timeline"})
    @timeline.add_events(Event.all)
    timelineJSON = @timeline.attribute_hash  
    respond_to do |format|
      format.html { render :"pages/timeline_js"}
      format.json { render :json => timelineJSON }
    end
  end

end
