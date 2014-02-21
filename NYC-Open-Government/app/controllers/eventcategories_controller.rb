class EventsCategoriesController < ApplicationController

  def destroy_link
    @event = Event.find(params[:event_id])
    @category = Category.find(params[:id])
    @event.categories.delete(@category)
    redirect_to edit_event_path(@event)
  end    

end