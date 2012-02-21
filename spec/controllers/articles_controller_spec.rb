require 'spec_helper'

describe ArticlesController do

  HTTP_AUTH_KEY = "pass"

  before do
    ENV["HTTP_AUTH_KEY"] = HTTP_AUTH_KEY
  end

  def authenticate
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials("", HTTP_AUTH_KEY)
  end

  def valid_attributes
    { title:        "About",
      slug:         "about",
      summary:      "About the Surf.",
      content:      "About the Surf.",
      published_at: Time.now }
  end
  
  let (:article) do
    mock_model(Article) do |a|
      a.stub(:slug).and_return("about")
      a.stub(:published_at).and_return(Time.new(2012))
    end
  end

  describe "GET index" do
    describe "atom format" do
      it "assigns the newest articles as @articles" do
        Article.stub(:ordered).and_return stub('set').tap { |s|
          s.stub(:limit).and_return([ article ])
        }
        get :index, {:format => 'atom'}
        assigns(:articles).should == [ article ]
      end
    end

    describe "html format" do
      it "assigns the newest article as @article" do
        Article.stub(:ordered).and_return([ article ])
        get :index, {}
        assigns(:article).should == article
      end
    end
  end

  describe "GET show" do
    it "assigns the requested article as @article" do
      Article.stub(:find_by_slug!).and_return(article)
      get :show, {:id => article.to_param}
      assigns(:article).should == article
    end
  end

  describe "GET archive" do
    it "assigns all articles as @articles" do
      Article.stub(:ordered).and_return([ article ])
      get :archive, {}
      assigns(:articles).should == [ [ 2012, [ article ] ] ]
    end
  end

  describe "POST create" do
    it "requires authentication" do
      expect {
        post :create, {:article => valid_attributes}
      }.to change(Article, :count).by(0)
      @response.status.should == 401
    end

    describe "authenticated" do
      before { authenticate }

      describe "with valid params" do
        it "creates a new article" do
          expect {
            post :create, {:article => valid_attributes}
          }.to change(Article, :count).by(1)
        end

        it "creates a new article with file push" do
          expect {
            attributes = valid_attributes.without(:content)
            attributes[:published_at] = "Time.parse(#{attributes[:published_at]})"
            post :create, {:attributes => attributes.to_s, 
                           :content    => valid_attributes[:content]}
          }.to change(Article, :count).by(1)
        end

        it "assigns a newly created article as @article" do
          post :create, {:article => valid_attributes}
          Article.stub(:new).and_return(article)
          article.stub(:save).and_return(true)
          assigns(:article).should be_a(Article)
          assigns(:article).should be_persisted
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved article as @article" do
          Article.any_instance.stub(:save).and_return(false)
          post :create, {:article => {}}
          assigns(:article).should be_a_new(Article)
        end
      end
    end
  end

  describe "PUT update" do
    it "requires authentication" do
      article = Article.create! valid_attributes
      put :update, {:id => article.to_param, :article => valid_attributes}
      @response.status.should == 401
    end

    describe "authenticated" do
      before { authenticate }

      describe "with valid params" do
        it "updates the requested article" do
          article = Article.create! valid_attributes
          put :update, {:id => article.to_param, :article => valid_attributes}
        end

        it "updates an article with file push" do
          article = Article.create! valid_attributes
          attributes = valid_attributes.without(:slug, :content)
          attributes[:published_at] = "Time.parse(#{attributes[:published_at]})"
          put :update, {:id         => article.to_param,
                        :attributes => attributes.to_s, 
                        :content    => valid_attributes[:content]}
        end

        it "assigns the requested article as @article" do
          Article.stub(:find_by_slug!).and_return(article)
          article.should_receive(:update_attributes).and_return(true)
          put :update, {:id => article.to_param, :article => {}}
          assigns(:article).should == article
        end
      end

      describe "with invalid params" do
        it "assigns the article as @article" do
          Article.stub(:find_by_slug!).and_return(article)
          article.stub(:update_attributes).and_return(false)
          put :update, {:id => article.to_param, :article => {}}
          assigns(:article).should == article
        end
      end
    end
  end

  describe "DELETE destroy" do
    it "requires authentication" do
      article = Article.create! valid_attributes
      expect {
        delete :destroy, {:id => article.to_param}
      }.to change(Article, :count).by(0)
      @response.status.should == 401
    end

    describe "authenticated" do
      before { authenticate }

      it "destroys the requested article" do
        article = Article.create! valid_attributes
        expect {
          delete :destroy, {:id => article.to_param}
        }.to change(Article, :count).by(-1)
      end
    end
  end

end
