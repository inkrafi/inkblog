class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :destroy, ]

  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = current_user.blog_post.build(blog_post_params)
    if @blog_post.save
      flash[:success] = 'Blog post was successfully created.'
      redirect_to @blog_post
    else
      render :new
    end
  end

  def edit
    @blog_post = BlogPost.find(params[:id])
  end

  def update
    @blog_post = BlogPost.find(params[:id])
    if @blog_post.update(blog_post_params)
      flash[:success] = 'Blog post was successfully updated.'
      redirect_to @blog_post
    else
      render :edit
    end
  end

  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    flash[:success] = 'Blog post deleted successfully.'
    redirect_to user_path(@blog_post.user.id)
  end

  def recent_blog
    @q = params[:q]
    @blog_posts = BlogPost.where("LOWER(title) LIKE :query OR LOWER(summary) LIKE :query", query: "%#{@q}%")

    if @blog_posts.blank?
      flash.now[:warning] = "No results found for '#{params[:q]}'."
    end

    render 'recent_blog'
  end

  private

  def set_blog_post
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :summary, :title_image_url, :tag_list)
  end
end
