module ApplicationHelper
  def article_path(article)
    "/#{article.slug}"
  end
end
