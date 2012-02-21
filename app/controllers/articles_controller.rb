class ArticlesController < ApplicationController
  before_filter :authorized!, :except => [ :index, :show ]
  
  def index
    respond_to do |format|
      format.atom { @articles = Article.ordered.limit(20) }
      format.html { @article = Article.ordered.first }
      format.json { render json: Article.ordered.limit(20) }
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
    @article = Article.new(article_params)

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
      if @article.update_attributes(article_params)
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

  private

  def article_params
    if params[:attributes] && params[:content]
      attributes = eval(params[:attributes])
      attributes[:content] = params[:content]
      attributes
    else
      params[:article]
    end
  end
end
