require 'spec_helper'

describe "articles/index" do
  before(:each) do
    assign(:articles, [
      stub_model(Article).tap { |a|
        a.stub(:content).and_return('First post.')
        a.stub(:published_at).and_return(Time.now)
      },
      stub_model(Article).tap { |a|
        a.stub(:content).and_return('About the Surf.')
        a.stub(:published_at).and_return(Time.now)
      }, 
    ])
  end

  it "renders successfully" do
    render formats: [ :atom ], template: "articles/index"
  end
end
