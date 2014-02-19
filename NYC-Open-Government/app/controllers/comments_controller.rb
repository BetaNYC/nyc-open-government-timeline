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
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to event_comment_path, notice: 'comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
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
      params.require(:comment).permit(:author, :content)
    end
end