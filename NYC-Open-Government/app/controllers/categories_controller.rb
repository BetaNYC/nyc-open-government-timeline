# category_controller.rb

class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params_event)
    if @category.save
      redirect_to category_path
    else
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params_event)
      redirect_to category_path
    else
      render "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to category_path 
  end

  def destroy_link
    @event = Event.find(params[:event_id])
    @category = Category.find(params[:category_id])
    @event.categories.delete(@category)
    redirect_to edit_event_path(@event)
  end    

  def show
    @category = Category.find(params[:id])
  end

  private
    def params_event
      params.require(:category).permit(:name)
    end
end