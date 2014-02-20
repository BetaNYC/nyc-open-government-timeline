Dir["./model/*.rb"].each {|file| require file}

class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    category = Category.find(params_event[:categories].to_i)
    @event = Event.new(clean_params(params_event))  #remove :categories from params
    @event.categories << category
    if @event.save
      redirect_to events_path
    else
      render "new"
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    category = Category.find(params_event[:categories].to_i)
    @event = Event.find(clean_params(params_event)) 
    @event.categories << category
    if @event.update_attributes(params_event)
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
      params.require(:event).permit(:name, :description, :categories, :date, :url, :status)
    end
end