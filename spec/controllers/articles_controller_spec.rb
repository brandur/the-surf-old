require 'spec_helper'

describe ArticlesController do

  def valid_attributes
    { :title => "About", :slug => "about", :content => "About the Surf." }
  end
  
  def valid_session
    {}
  end

  let (:article) do
    article = mock_model(Article)
    article.stub(:slug).and_return('about')
    article
  end

  describe "GET index" do
    it "assigns all article as @article" do
      Article.stub(:ordered).and_return([ article ])
      get :index, {}, valid_session
      assigns(:article).should == article
    end
  end

  describe "GET show" do
    it "assigns the requested article as @article" do
      Article.stub(:find_by_slug!).and_return(article)
      get :show, {:id => article.to_param}, valid_session
      assigns(:article).should == article
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Article" do
        expect {
          post :create, {:article => valid_attributes}, valid_session
        }.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, {:article => valid_attributes}, valid_session
        Article.stub(:new).and_return(article)
        article.stub(:save).and_return(true)
        assigns(:article).should be_a(Article)
        assigns(:article).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved article as @article" do
        Article.any_instance.stub(:save).and_return(false)
        post :create, {:article => {}}, valid_session
        assigns(:article).should be_a_new(Article)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested article" do
        article = Article.create! valid_attributes
        put :update, {:id => article.to_param, :article => valid_attributes}, valid_session
      end

      it "assigns the requested article as @article" do
        Article.stub(:find_by_slug!).and_return(article)
        article.should_receive(:update_attributes).and_return(true)
        put :update, {:id => article.to_param, :article => {}}, valid_session
        assigns(:article).should == article
      end
    end

    describe "with invalid params" do
      it "assigns the article as @article" do
        Article.stub(:find_by_slug!).and_return(article)
        article.stub(:update_attributes).and_return(false)
        put :update, {:id => article.to_param, :article => {}}, valid_session
        assigns(:article).should == article
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested article" do
      article = Article.create! valid_attributes
      expect {
        delete :destroy, {:id => article.to_param}, valid_session
      }.to change(Article, :count).by(-1)
    end
  end

end
