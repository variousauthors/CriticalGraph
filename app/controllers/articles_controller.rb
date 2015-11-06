class ArticlesController < ApplicationController
  require 'csv'
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: Rails.application.secrets["authentication"]["name"], password: Rails.application.secrets["authentication"]["password"]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    author = Author.find_or_create_by!({ handle: params[:article][:author] })
    author.articles << @article

    CSV.parse(params[:article][:references]).each do |reference|
      author = Author.find_or_create_by(handle: reference.first)
      url = reference.last

      reference = Article.find_or_create_by!({ url: url, author: author })

      @article.references << reference
    end

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:url, :title, :author_id, :parent_id)
    end
end
