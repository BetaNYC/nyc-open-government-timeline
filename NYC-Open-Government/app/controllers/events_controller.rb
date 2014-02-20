Dir["./model/*.rb"].each {|file| require file}

class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    attributes_hash = params_event[:categories_attributes]
    array = []
    attributes_hash.each do |k, v|
      v.each do |attr, value|
        array << value
      end
    end
    objects = []
    array.each do |name|
      found = Category.find_by_name(name)
      if found
        objects << found
      else
        objects << Category.create(:name => name)
      end
    end
    @event = Event.new(clean_params(params_event))
    @event.categories << objects
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
    hash = params_event[:categories_attributes]
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
      params.require(:event).permit(:name, :description, :date, :url, :status, categories_attributes: [:name])
    end
end