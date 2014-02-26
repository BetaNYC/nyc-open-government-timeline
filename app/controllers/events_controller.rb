require "parser.rb"

class EventsController < ApplicationController

  def index
    @events = Event.all

    respond_to do |format|
      format.html
      # to_json :include => :categories is a ActiveRecord function to include nested resources
      format.json { render :json => @events.to_json(:include => :categories)}
    end
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
    debugger
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