class Article < ActiveRecord::Base
  scope :ordered, order('created_at DESC')
  validates_presence_of :title, :slug, :content

  def content_html
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
      :fenced_code_blocks => true, :hard_wrap => true)
    renderer.render(content)
  end

  def to_param
    slug
  end
end
