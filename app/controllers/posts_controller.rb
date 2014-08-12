class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :destroy, :kudos]

  def index
    @posts = Post.all
  end

  def show
    
  end

  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Your new blog post was successfully created.' }
        format.json { render :show, status: :created, location: @posts}
      else
        format.html { redirect_to new_post_path, error: "The post could not be created." }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = "Your blog post is updated"
      redirect_to post_path
    else
      flash[:error] = "Your blog post cannot be updated"
      render :edit
    end
  end


  def destroy
    if @post.destroy 
      flash[:success] = "You ain't got that post no more!"
    else
      flash[:error] = "It cannot be deleted"
    end
    redirect_to posts_path
  end

  def kudos
    @post.update_attributes(:kudos_count => @post.kudos_count + 1)
    redirect_to post_path(@post), notice: "Thank you!"
  end


  private
  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :category, :anger, :kudos_count)
  end




end
