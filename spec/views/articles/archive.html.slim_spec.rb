require 'spec_helper'

describe "articles/archive" do
  before(:each) do
    assign(:articles, [
      [ 2012, [ stub_model(Article).tap { |a|
        a.stub(:content).and_return('First post.')
        a.stub(:published_at).and_return(Time.now)
      } ] ],
      [ 2011, [ stub_model(Article).tap { |a|
        a.stub(:content).and_return('About the Surf.')
        a.stub(:published_at).and_return(Time.now)
      } ] ], 
    ])
  end

  it "renders successfully" do
    render
  end
end
