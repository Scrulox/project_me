class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:index, :edit, :update, :destroy]

  def index
  end

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.kudos == true
      @post.update_attributes(:kudos_count => 10)
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Your comment is added' }
        format.json { render "posts/show", status: :created, location: @post}
      else
        format.html { redirect_to new_post_comment_path, error: "This comment could not be created." }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(comment_params)
      flash[:success] = "Your comment is updated"
      redirect_to post_path(@post)
    else
      flash[:error] = "Your comment cannot be updated"
      render :edit
    end
  end


  def destroy
    if @comment.delete
      flash[:success] = "Your comment is removed!"
    else
      flash[:error] = "Your comment cannot be deleted"
    end
    redirect_to post_path(@post)
  end



  private
  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def post_params
    params.require(:post).permit(:title, :body, :category, :anger, :kudos_count)
  end

end
