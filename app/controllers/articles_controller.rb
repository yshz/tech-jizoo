class ArticlesController < ApplicationController
  before_action :set_ariticles

  def index
  end

  def show
    year     = params[:year]
    month    = params[:month]
    day      = params[:day]
    title    = params[:title]
    file_name = "#{year}-#{month}-#{day}-#{title}"
    @article = Article.find_by!(file_name: file_name)
  end

  private

  def set_ariticles
    @articles = Article.all
  end
end
