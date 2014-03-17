# category_controller.rb

class CategoriesController < ApplicationController

  #triggers devise method that redirects to login for all actions with exceptions
  before_filter :authenticate_user!, :except => [:show, :index, :api_by_name]

  def index
    @categories = Category.all

    respond_to do |format|
      format.html
      format.json { render :json => @categories.to_json(:include => :events) }
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params_event)
    if @category.save
      redirect_to categories_path
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
    redirect_to categories_path 
  end

  def show
    @category = Category.find(params[:id])
    @events = @category.events
  end

  def api_by_name
    @category = query_by_name(Category.all, params[:name])
    
    respond_to do |format|
      format.json { render :json => @category}
    end
  end


  private
    def params_event
      params.require(:category).permit(:name)
    end
end