class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    year     = params[:year]
    month    = params[:month]
    day      = params[:day]
    title    = params[:title]
    file_name = "#{year}-#{month}-#{day}-#{title}"
    @article = Article.find_by!(file_name: file_name)
  end
end
