# frozen_string_literal: true

class PostsController < AuthenticationController
  skip_before_action :verify_login, only: %i[index show]
  before_action :load_post, only: %i[update show edit destroy add_comment]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
    if stale?(last_modified: @post.updated_at)
      respond_to do |format|
        format.html
        format.json { render json: @post }
      end
    end
    expires_in 1.day, :public => true
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'The post was created!'
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = 'Update successful'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post destroyed'
    redirect_to root_path
  end

  def add_comment
    Comment.create({ content: params[:comment], commentable: @post, user: @current_user })
    redirect_to action: 'show', id: @post.id
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :author_id, :image)
  end

  def load_post
    @post = Post.find_by(id: params[:id])
  end
end
