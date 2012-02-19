require 'net/http'
require 'open-uri'

module ApplicationHelper
  def lorem_ipsum
    @@lorem_ipsum ||= fetch_lorem_ipsum
  end

  private

  @@lorem_ipsum = nil

  def fetch_lorem_ipsum
    options = {}
    options[:language]  ||= "text" # XML, JSON or Text
    options[:format]    ||= "plain" # Plain or HTML
    options[:type]      ||= "essay" # Essay or Blog

    # http://lorem-ipsum.me/api/xml?format=plain&type=blog
    uri       = "http://lorem-ipsum.me/api/#{options[:language]}?format=#{options[:format]}&type=#{options[:type]}"
    request   = URI.parse(uri)
    response  = Net::HTTP.get_response(request).body
  end
end
