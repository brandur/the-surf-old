require 'spec_helper'

describe Article do
  def valid_attributes
    { title:        "About",
      slug:         "about",
      summary:      "About the Surf.",
      content:      "About the Surf.",
      published_at: Time.now }
  end

  describe "validations" do
    it "validates successfully" do
      Article.new(valid_attributes).valid?.should be_true
    end

    it "validates presence of :title" do
      Article.new(valid_attributes.without(:title)).valid?.should be_false
    end

    it "validates presence of :slug" do
      Article.new(valid_attributes.without(:slug)).valid?.should be_false
    end

    it "validates presence of :content" do
      Article.new(valid_attributes.without(:content)).valid?.should be_false
    end

    it "validates uniqueness of :slug" do
      Article.create!(valid_attributes)
      Article.new(valid_attributes).valid?.should be_false
    end
  end

  it "uses its slug as its parameter" do
    Article.new(valid_attributes).to_param.should == valid_attributes[:slug]
  end

  it "renders content as markdown" do
    Article.new(:content => "**strong text**").content_html.should == 
      "<p><strong>strong text</strong></p>\n"
  end

  it "renders summary as markdown" do
    Article.new(:summary => "**strong text**").summary_html.should == 
      "<p><strong>strong text</strong></p>\n"
  end
end
