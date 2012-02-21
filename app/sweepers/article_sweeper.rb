class ArticleSweeper < ActionController::Caching::Sweeper
  observe Article # This sweeper is going to keep an eye on the Article model
 
  # If our sweeper detects that a Article was created call this
  def after_create(article)
    Rails.cache.clear
  end
 
  # If our sweeper detects that a Article was updated call this
  def after_update(article)
    Rails.cache.clear
  end
 
  # If our sweeper detects that a Article was deleted call this
  def after_destroy(article)
    Rails.cache.clear
  end
end
