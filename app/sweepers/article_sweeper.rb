class ArticleSweeper < ActionController::Caching::Sweeper
  observe Article # This sweeper is going to keep an eye on the Article model
 
  # If our sweeper detects that a Article was created call this
  def after_create(article)
    expire_cache_for(article)
  end
 
  # If our sweeper detects that a Article was updated call this
  def after_update(article)
    expire_cache_for(article)
  end
 
  # If our sweeper detects that a Article was deleted call this
  def after_destroy(article)
    expire_cache_for(article)
  end
 
  private

  def expire_cache_for(article)
    expire_action(:controller => 'articles', :action => 'index')
    expire_action(:controller => 'articles', :action => 'show')
    expire_action(:controller => 'articles', :action => 'archive')
  end
end
