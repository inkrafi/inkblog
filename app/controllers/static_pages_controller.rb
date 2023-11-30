class StaticPagesController < ApplicationController
  def home
    @blog_posts = BlogPost.all
  end

  def about
  end

  def blog
  end

  def post
    @blog_post = BlogPost.find(params[:id])
  end

end
