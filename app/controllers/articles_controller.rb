class ArticlesController < ApplicationController
  before_filter :authorized!, :except => [ :index, :show, :archive ]
  cache_sweeper :article_sweeper
  caches_action :index, :archive, :cache_path => Proc.new { |c|
    "/#{c.controller_path}/#{c.action_name}.#{c.request.format}#{c.pjax? ? "/pjax" : ""}"
  }
  caches_action :show, :cache_path => Proc.new { |c|
    "/#{c.controller_path}/#{c.action_name}/#{c.params[:id]}.#{c.request.format}#{c.pjax? ? "/pjax" : ""}"
  }
  
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

  def archive
    @articles = Article.ordered.group_by{ |a| a.published_at.year }.sort.reverse

    respond_to do |format|
      format.html
      format.json { render json: @articles }
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
