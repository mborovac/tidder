require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  #validations
  context 'when missing email' do
    # before { user.email = nil }
    # it 'validates presence of email' do
    #   expect(user.valid?).to eq(false)
    #   expect(user.errors[:email].first).not_to be_nil
    # end
    it { should validate_presence_of(:email) }
  end

  context 'when missing password' do
    it { should validate_presence_of(:password) }
  end

  context 'when password is too short' do
    it { should validate_length_of(:password) }
  end

  #associations
  context 'when created' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:upvotes).dependent(:destroy) }
    it { should have_many(:subreddit_subscriptions).dependent(:destroy) }
    it { should have_many(:subreddits).through(:subreddit_subscriptions).dependent(:destroy) }
  end


  #token created
  context 'when created' do
    let(:user) { FactoryGirl.create(:user) }
    it 'checks if token was created' do
      expect(user.token).not_to be_nil
    end
  end
end
