require 'spec_helper'

describe "articles/show" do
  before(:each) do
    @article = assign(:article, stub_model(Article))
    @article.stub(:content).and_return('About the Surf.')
    @article.stub(:created_at).and_return(Time.now)
  end

  it "renders successfully" do
    render
  end
end
