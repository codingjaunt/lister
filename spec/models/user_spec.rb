require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures(:users, :lists)
  let(:user) { users(:santa) }

  describe 'associations' do
    it 'has many lists' do
      expect(user.lists.count > 0).to be(true)
    end
  end
end
