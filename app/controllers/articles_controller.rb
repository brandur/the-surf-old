class ArticlesController < ApplicationController
  before_filter :authenticate, :exception => [ :index, :show ]
  
  def index
    @article = Article.ordered.first

    respond_to do |format|
      format.html 
      format.json { render json: @article }
    end
  end

  def show
    @article = Article.find_by_slug!(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end

  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.json { render json: @article, status: :created, location: @article }
      else
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @article = Article.find_by_slug!(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.json { head :no_content }
      else
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article = Article.find_by_slug!(params[:id])
    @article.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
