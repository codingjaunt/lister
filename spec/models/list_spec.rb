require 'rails_helper'

RSpec.describe List, type: :model do
  fixtures(:users)
  let(:user) { users(:santa) }
  subject { described_class.new(name: 'Hello', user_id: user.id) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject.valid?).to be(true)
    end

    it 'is not valid without name' do
      subject.name = nil
      expect(subject.valid?).to be(false)
      subject.name = ''
      expect(subject.valid?).to be(false)
    end

    it 'is not valid with too long a name' do
      subject.name = 'a' * 256
      expect(subject.valid?).to be(false)
    end

    it 'only allows unique name' do
      subject.dup.save
      expect(subject.valid?).to be(false)
    end
  end

  describe 'associations' do
    it 'belongs to user' do
      expect(subject.user).to eq(user)
    end
  end
end
