require 'spec_helper'

describe "articles/index" do
  before(:each) do
    @article = assign(:article, stub_model(Article))
    @article.stub(:content).and_return('About the Surf.')
    @article.stub(:created_at).and_return(Time.now)
=begin
    assign(:series, [
      stub_model(Series),
      stub_model(Series)
    ])
=end
  end

  it "renders successfully" do
    render
  end
end
