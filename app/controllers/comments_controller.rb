class CommentsController < ApplicationController
  before_action :load_commentable
  before_action :all_comments, only: [:index, :create]
  before_action :authenticate_user!, except: [:index]
  respond_to    :html, :json, :js

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
      binding.pry
      respond_to do |format|
        format.html { redirect_to @commentable }
        format.js
      end
      # redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    respond_with @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to @commentable }
        format.js
      end
    end
  end

private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def all_comments
    @comments = @commentable.comments
  end
end
