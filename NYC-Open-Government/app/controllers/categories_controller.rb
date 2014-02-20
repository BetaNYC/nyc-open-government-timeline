# category_controller.rb

class CategoriesController < ApplicationController

  def index
    @categories = category.all
  end

  def new
    @category = category.new
  end

  def create
    @category = category.new(params_event)
    if @category.save
      redirect_to category_path
    else
      render "new"
    end
  end

  def edit
    @category = category.find(params[:id])
  end

  def update
    @category = category.find(params[:id])
    if @category.update_attributes(params_event)
      redirect_to category_path
    else
      render "edit"
    end
  end

  def destroy
    @category = category.find(params[:id])
    @category.destroy
    redirect_to category_path 
  end

  def show
    @category = category.find(params[:id])
  end

  private
    def params_event
      params.require(:category).permit(:name)
    end
end