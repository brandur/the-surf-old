require "spec_helper"

describe ArticlesController do
  describe "routing" do

    it "routes to #index" do
      get("/articles").should route_to("articles#index")
    end

    it "routes to #show" do
      get("/articles/about").should route_to("articles#show", :id => "about")
    end

    it "routes to #create" do
      post("/articles").should route_to("articles#create")
    end

    it "routes to #update" do
      put("/articles/about").should route_to("articles#update", :id => "about")
    end

    it "routes to #destroy" do
      delete("/articles/about").should route_to("articles#destroy", :id => "about")
    end

  end
end
