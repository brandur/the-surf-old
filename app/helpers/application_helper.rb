module ApplicationHelper
  def article_path(article)
    "/#{article.slug}"
  end

  def pjax?
    request.headers['X-PJAX']
  end
end
