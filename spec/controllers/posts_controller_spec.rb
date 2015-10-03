require 'rails_helper'
require 'spec_helper'

RSpec.describe PostsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:subreddit) { FactoryGirl.create(:subreddit) }
  let!(:post2) { FactoryGirl.create(:post) }
  let(:valid_attributes) {
                            { title: 'Post1',
                              content: 'Some random post content.'
                            }
                          }
  let(:invalid_attributes)  {
                              { title: '',
                                content: ''
                              }
                            }

  before { sign_in user }

  describe "GET #new" do
    it "renders new" do
      get :new, subreddit_id: subreddit.id
      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new Post" do
        expect  {
                  post :create, post: valid_attributes, subreddit_id: subreddit.id
                }.to change(Post, :count).by(1)
      end
      it "redirects to the created post" do
        post :create, post: valid_attributes, subreddit_id: subreddit.id
        expect(response).to redirect_to(subreddit_post_path(id: Post.last.id))
      end
    end
    context "with invalid attributes" do
      it "re-renders new" do
        post :create, post: invalid_attributes, subreddit_id: subreddit.id
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    it "renders show" do
      get :show, subreddit_id: subreddit.id, id: post2.id
      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    it "renders edit" do
      get :edit, subreddit_id: subreddit.id, id: post2.id
      expect(response).to be_success
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    let(:post2) { FactoryGirl.create(:post) }
    context "with valid attributes" do
      it "updates an existing Post" do
        expect  {
                  patch :update, post: valid_attributes, subreddit_id: subreddit.id, id: post2.id
                }.to change(Post, :count).by(0)
      end
      it "redirects to the edited post" do
        patch :update, post: valid_attributes, subreddit_id: subreddit.id, id: post2.id
        expect(response).to redirect_to(subreddit_post_path)
      end
    end
    context "with invalid attributes" do
      it "re-renders edit" do
        patch :update, post: invalid_attributes, subreddit_id: subreddit.id, id: post2.id
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "removes the post from database" do
      expect  {
                delete :destroy, subreddit_id: subreddit.id, id: post2.id
              }.to change(Post, :count).by(-1)
    end
    it "redirects to the subreddit page" do
      delete :destroy, subreddit_id: subreddit.id, id: post2.id
      expect(response).to redirect_to(subreddit_path(subreddit.id))
    end
  end
end
