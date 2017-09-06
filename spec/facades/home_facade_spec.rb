require 'rails_helper'

RSpec.describe HomeFacade, type: :facade do
  fixtures(:users)
  let(:user) { users(:santa) }

  describe '#new' do
    let(:lists) { double('Lists') }
    subject { HomeFacade.new(user: user, lists_facade: lists) }

    it 'handles resource lists' do
      expect(lists).to receive(:new_list).and_return(:list)
      expect(lists).to receive(:lists).with(user: user).and_return(:lists)

      expect(subject.list).to eq(:list)
      expect(subject.lists).to eq(:lists)
    end
  end
end
