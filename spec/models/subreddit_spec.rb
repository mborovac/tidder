require 'rails_helper'
require 'spec_helper'

RSpec.describe Subreddit, type: :model do
  let(:subreddit) { FactoryGirl.build(:subreddit) }

  #validations
  context 'when missing name' do
    it { should validate_presence_of(:name) }
  end

  context 'when name is too short' do
    it { should validate_length_of(:name).is_at_least(3) }
  end

  context 'when name is too long' do
    it { should validate_length_of(:name).is_at_most(20) }
  end

  context 'when name is not unique' do
    it { should validate_uniqueness_of(:name) }
  end

  context 'when description is too long' do
    it { should validate_length_of(:description).is_at_most(500) }
  end

  #associations
  context 'when created' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:subreddit_subscriptions).dependent(:destroy) }
    it { should have_many(:users).through(:subreddit_subscriptions).dependent(:destroy) }
  end

  #newest
  describe '.newest' do
    let(:first) { FactoryGirl.create(:subreddit) }
    let(:second) { FactoryGirl.create(:subreddit) }
    let(:third) { FactoryGirl.create(:subreddit) }

    context 'when ordered with newest' do
      before { first.update(updated_at: Time.now) }
      before { second.update(updated_at: Time.now + 1.hour) }
      before { third.update(updated_at: Time.now + 2.hours) }
      it 'orders by newest scope' do
        expect(Subreddit.newest).to eq([third, second, first])
      end
    end
  end

  #trending
  describe '.trending' do
    let(:first) { FactoryGirl.create(:subreddit) }
    let(:second) { FactoryGirl.create(:subreddit) }
    let(:third) { FactoryGirl.create(:subreddit) }
    let(:user) { FactoryGirl.create(:user) }

    context 'when ordered with trending and created_at differs' do
      before { first.update(created_at: Time.now - 3.hours, users:[user, user]) }
      before { second.update(created_at: Time.now - 1.hour, users:[user, user]) }
      before { third.update(created_at: Time.now - 2.hours, users:[user, user]) }

      it 'orders by trending scope' do
        expect(Subreddit.trending).to eq([second, third, first])
      end
    end

    context 'when ordered with trending and number of users differs' do
      before { first.update(created_at: Time.now, users:[user, user, user, user]) }
      before { second.update(created_at: Time.now, users:[user, user, user]) }
      before { third.update(created_at: Time.now, users:[user, user]) }

      it 'orders by trending scope' do
        expect(Subreddit.trending).to eq([first, second, third])
      end
    end
  end

end
