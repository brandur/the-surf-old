require 'spec_helper'

describe "articles" do
  describe "GET /articles" do
    it "succeeds" do
      get articles_path
      response.status.should be(200)
    end
  end
end
