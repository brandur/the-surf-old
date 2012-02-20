module Config
  extend self

  def http_auth_key
    @http_auth_key ||= env!("HTTP_AUTH_KEY")
  end

  private

  def env(k)
    ENV[k] unless ENV[k].blank?
  end

  def env!(k)
    env(k) || raise("missing_environment=#{k}")
  end

end
