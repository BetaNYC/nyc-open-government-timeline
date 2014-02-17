class EventController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params_event)
    if @event.save
      redirect_to event_path
    else
      render "new"
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private
    def params_event
      params.require(:event).permit(:name, :description, :category, :date, :url, :status)
    end
end
