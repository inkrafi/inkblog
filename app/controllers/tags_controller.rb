class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(slug: params[:id]) || Tag.find(params[:id])
  end
end
