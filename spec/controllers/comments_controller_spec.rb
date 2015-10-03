require 'rails_helper'
require 'spec_helper'

RSpec.describe CommentsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:subreddit) { FactoryGirl.create(:subreddit) }
  let(:post2) { FactoryGirl.create(:post, subreddit_id: subreddit.id) }
  # let!(:comment) { FactoryGirl.create(:comment) }
  let(:valid_attributes) {
                            { content: 'Some random comment content.',
                              post_id: post2.id
                            }
                          }
  let(:invalid_attributes)  {
                              { content: '',
                                post_id: nil
                              }
                            }

  before { sign_in user }

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new Comment" do
        expect  {
                  post :create, comment: valid_attributes, subreddit_id: subreddit.id, post_id: post2.id
                }.to change(Comment, :count).by(1)
      end
      it "sends an e-mail to post creator" do
        expect  {
                  post :create, comment: valid_attributes, subreddit_id: subreddit.id, post_id: post2.id
                }.to change { ActionMailer::Base.deliveries.count }.by(1)
        mail = ActionMailer::Base.deliveries.last
        expect(mail['to'].to_s).to eq(post2.user.email)
        expect(mail['from'].to_s).to eq('no-reply@tidder.com')
        expect(mail['subject'].to_s).to eq("#{post2.title} - New Comment")
      end
      it "redirects back to the post" do
        post :create, comment: valid_attributes, subreddit_id: subreddit.id, post_id: post2.id
        expect(response).to redirect_to(subreddit_post_path(id: post2.id))
      end
    end
    context "with invalid attributes" do
      it "re-renders new" do
        expect  {
                  post :create, comment: invalid_attributes, subreddit_id: subreddit.id, post_id: post2.id
                }.to change(Comment, :count).by(0)
      end
      it "redirects back to the post" do
        post :create, comment: invalid_attributes, subreddit_id: subreddit.id, post_id: post2.id
        expect(response).to redirect_to(subreddit_post_path(id: post2.id))
      end
    end
  end
end
