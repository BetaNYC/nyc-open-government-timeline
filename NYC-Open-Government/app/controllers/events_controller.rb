Dir["./model/*.rb"].each {|file| require file}

class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @status = "new"
  end

  def create
    # debugger
    @event = Event.new(clean_params(params_event))
    @event.categories << audit_categories(params_event)
    if @event.save
      redirect_to events_path
    else
      render "new"
    end
  end

  def edit
    @event = Event.find(params[:id])
    @status = "edit"
  end

  def update
    @event = Event.find(params[:id])
    @event.categories << audit_categories(params_event)
    if @event.update_attributes(clean_params(params_event))
      redirect_to events_path
    else
      render "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path 
  end

  def show
    @event = Event.find(params[:id])
  end

  private
    def params_event
      params.require(:event).permit(:name, :description, :date, :url, :status, categories_attributes: [:name])
    end
end