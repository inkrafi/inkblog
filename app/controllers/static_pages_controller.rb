class StaticPagesController < ApplicationController
  def home
    @blog_posts = BlogPost.order(created_at: :desc).limit(3)
  end

  def about
  end

  def blog
    @blog_posts = BlogPost.all
    @tags = Tag.all
  end

  def post
    @blog_post = BlogPost.find(params[:id])
  end

end
