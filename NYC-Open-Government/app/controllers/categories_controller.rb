# categories_controller.rb

class CategoriesController < ApplicationController

  def index
    @categories = Categories.all
  end

  def new
    @category = Categories.new
  end

  def create
    @category = Categories.new(params_event)
    if @category.save
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
    @category = Categories.find(params[:id])
  end

  def update
    @category = Categories.find(params[:id])
    if @category.update_attributes(params_event)
      redirect_to categories_path
    else
      render "edit"
    end
  end

  def destroy
    @category = Categories.find(params[:id])
    @category.destroy
    redirect_to categories_path 
  end

  def show
    @category = Categories.find(params[:id])
  end

  private
    def params_event
      params.require(:category).permit(:name)
    end
end