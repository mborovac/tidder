require 'rails_helper'
require 'spec_helper'

RSpec.describe SubredditsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:subreddit) { FactoryGirl.create(:subreddit) }
  let(:valid_attributes) {
                            { name: 'Subreddit1',
                              description: 'Some random subreddit description.'
                            }
                          }
  let(:invalid_attributes)  {
                              { name: '',
                                description: ''
                              }
                            }

  before { sign_in user }

  describe "GET #index" do
    it "renders index" do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "renders new" do
      get :new
      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new Subreddit" do
        expect  {
                  post :create, subreddit: valid_attributes
                }.to change(Subreddit, :count).by(1)
      end
      it "redirects to the created subreddit" do
        post :create, subreddit: valid_attributes
        expect(response).to redirect_to(Subreddit.last)
      end
    end
    context "with invalid attributes" do
      it "re-renders new" do
        post :create, subreddit: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    it "renders show" do
      get :show, id: subreddit.id
      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  describe "GET #trending" do
    it "renders trending" do
      get :trending
      expect(response).to be_success
      expect(response).to render_template(:trending)
    end
  end
end
