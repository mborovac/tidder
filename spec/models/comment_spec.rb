require 'rails_helper'
require 'spec_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryGirl.build(:comment) }

  #validations
  context 'when missing content' do
    it { should validate_presence_of(:content) }
  end

  context 'when missing post_id' do
    it { should validate_presence_of(:post_id) }
  end

  #associations
  context 'when created' do
    it { should belong_to(:post).counter_cache(true) }
    it { should belong_to(:user) }
  end

  #newest
  describe '.newest' do
    let(:first) { FactoryGirl.create(:comment) }
    let(:second) { FactoryGirl.create(:comment) }
    let(:third) { FactoryGirl.create(:comment) }

    context 'when ordered with newest' do
      before { first.update(updated_at: Time.now) }
      before { second.update(updated_at: Time.now + 1.hour) }
      before { third.update(updated_at: Time.now + 2.hours) }
      it 'orders by newest scope' do
        expect(Comment.newest).to eq([third, second, first])
      end
    end
  end
end
