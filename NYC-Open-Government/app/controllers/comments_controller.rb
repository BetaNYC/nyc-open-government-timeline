class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
    @event = Event.find(params[:event_id])
  end

  def new
    @comment = Comment.new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @comment = Comment.new(params_comment)
    @comment.event_id = params[:event_id]
    if @comment.save
      redirect_to event_url(@event)
    else
      render "new"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @event = Event.find(params[:event_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @event = Event.find(params[:event_id])
    if @comment.update_attribute(params_comment)
      redirect_to event_comment_path(@event, @comment)
    else
      render "new"
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to event_url(@event)
  end

  private
    def params_comment
      params.require(:comment).permit(:content, :author)
    end
end