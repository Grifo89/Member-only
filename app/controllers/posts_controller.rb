class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.build_user(id: @current_user.id)
    if @post.save
      flash.now[:success] = "Post submitted 😂😂😂 "
      redirect_to index_path
    else
      render 'new'
    end
  end

  def index
    @post = Post.all
  end


  private
  # Before filters

    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    def post_params
      params.require(:post).permit(:title, :entry)
    end
end
