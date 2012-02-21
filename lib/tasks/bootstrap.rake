require 'lorem_ipsum'

namespace :bootstrap do
  desc "Bootstrap to a state useful for development"
  task :dev => [ :sample ]

  desc "Create sample articles"
  task :sample => :environment do
    create_lorem_ipsum_article title: "Lorem ipsum dolor sit amet",                     slug: "lorem"
    create_lorem_ipsum_article title: "Consectetur adipisicing elit",                   slug: "consectetur"
    create_lorem_ipsum_article title: "Ea maxime temporibus itaque tempora",            slug: "ea"
    create_lorem_ipsum_article title: "Iure saepe modi mollitia nostrum",               slug: "iure"
    create_lorem_ipsum_article title: "Incididunt deleniti et molestiae exercitation ", slug: "incididunt"
  end
end

def create_lorem_ipsum_article(attributes = {})
  content = lorem_ipsum
  attributes = 
    { summary: content[0..160],
      content: content,
      published_at: Time.now }.merge!(attributes)
  Article.create!(attributes)
end
