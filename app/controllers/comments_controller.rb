class CommentsController < ApplicationController
  before_action :load_commentable
  before_action :authenticate_user!, except: [:index]

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

  # def edit
  #   @comment = Comment.find(params[:id])
  # end
  #
  # def update
  #   @comment = Comment.find(params[:id])
  #   @comment.update(comment_params[:content])
  #   if save
  #     redirect_to @commentable
  #   else
  #     render 'decks#show'
  #   end
  # end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete

    redirect_to @commentable
  end

private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
