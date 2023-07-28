require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:tea) }
  end

  # describe 'factory' do
  #   it 'has a valid factory' do
  #     subscription = create(:subscription)
  #     expect(subscription).to be_valid
  #   end
  # end
end