require 'spec_helper'

describe "articles/show" do
  before(:each) do
    @article = assign :article, stub_model(Article).tap { |a|
      a.stub(:content).and_return('About the Surf.')
      a.stub(:published_at).and_return(Time.now)
    }
  end

  it "renders successfully" do
    render
  end
end
