require 'spec_helper'

describe "articles" do
  let (:article) do
    stub_model(Article).tap do |a|
      a.stub(:title).and_return("About")
      a.stub(:slug).and_return("about")
      a.stub(:content).and_return("About the Surf.")
      a.stub(:created_at).and_return(Time.now)
    end
  end

  describe "GET /articles" do
    it "succeeds" do
      Article.stub(:ordered).and_return stub('set').tap { |s|
        s.stub(:first).and_return(article)
        s.stub(:limit).and_return([])
      }
      get articles_path
      response.status.should be(200)
    end
  end
end
