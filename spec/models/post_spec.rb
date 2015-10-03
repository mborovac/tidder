require 'rails_helper'
require 'spec_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.build(:post) }

  #validations
  context 'when missing title' do
    it { should validate_presence_of(:title) }
  end

  context 'when missing content' do
    it { should validate_presence_of(:content) }
  end

  context 'when missing subreddit' do
    it { should validate_presence_of(:subreddit_id) }
  end

  #associations
  context 'when created' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:upvotes).dependent(:destroy) }
    it { should belong_to(:user) }
    it { should belong_to(:subreddit) }
  end

  #newest
  describe '.newest' do
    let(:first) { FactoryGirl.create(:post) }
    let(:second) { FactoryGirl.create(:post) }
    let(:third) { FactoryGirl.create(:post) }

    context 'when ordered with newest' do
      before { first.update(updated_at: Time.now) }
      before { second.update(updated_at: Time.now + 1.hour) }
      before { third.update(updated_at: Time.now + 2.hours) }
      it 'orders by newest scope' do
        expect(Post.newest).to eq([third, second, first])
      end
    end
  end

  #trending
  describe '.trending' do
    let(:first) { FactoryGirl.create(:post) }
    let(:second) { FactoryGirl.create(:post) }
    let(:third) { FactoryGirl.create(:post) }
    let(:upvote1) { FactoryGirl.create(:upvote, post: first) }
    let(:upvote2) { FactoryGirl.create(:upvote, post: first) }
    let(:upvote3) { FactoryGirl.create(:upvote, post: second) }
    let(:upvote4) { FactoryGirl.create(:upvote, post: second) }
    let(:upvote5) { FactoryGirl.create(:upvote, post: third) }
    let(:upvote6) { FactoryGirl.create(:upvote, post: third) }
    let(:upvote7) { FactoryGirl.create(:upvote, post: first) }
    let(:upvote8) { FactoryGirl.create(:upvote, post: first) }
    let(:upvote9) { FactoryGirl.create(:upvote, post: second) }

    context 'when ordered with trending and created_at differs' do
      before { first.update(created_at: Time.now - 3.hours, upvotes: [upvote1, upvote2]) }
      before { second.update(created_at: Time.now - 1.hour, upvotes: [upvote3, upvote4]) }
      before { third.update(created_at: Time.now - 2.hours, upvotes: [upvote5, upvote6]) }

      it 'orders by trending scope' do
        expect(Post.trending).to eq([second, third, first])
      end
    end

    context 'when ordered with trending and number of upvotes differs' do
      before { first.update(created_at: Time.now, upvotes: [upvote1, upvote2, upvote7, upvote8]) }
      before { second.update(created_at: Time.now, upvotes: [upvote3, upvote4, upvote9]) }
      before { third.update(created_at: Time.now, upvotes: [upvote5, upvote6]) }

      it 'orders by trending scope' do
        expect(Post.trending).to eq([first, second, third])
      end
    end
  end
end
