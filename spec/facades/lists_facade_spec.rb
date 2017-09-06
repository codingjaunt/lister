require 'rails_helper'

RSpec.describe ListsFacade, type: :facade do
  fixtures(:users)
  let(:user) { users(:santa) }
  let(:list_model) { double(List) }

  describe '.new_list' do
    subject { ListsFacade.new_list(list_model: list_model) }

    it 'creates new list' do
      expect(list_model).to receive(:new).and_return(:new_list)

      expect(subject).to eq(:new_list)
    end
  end

  describe '.lists' do
    subject { ListsFacade.lists(user: user) }

    it 'finds users lists' do
      expect(user).to receive(:lists).and_return(:lists)

      expect(subject).to eq(:lists)
    end
  end

  describe '.index' do
    subject { ListsFacade.index(user: user) }

    it 'to set list and lists' do
      expect(user).to receive(:lists).and_return(:lists)
      expect(ListsFacade).to receive(:new_list).and_return(:list)

      expect(subject.list).to eq(:list)
      expect(subject.lists).to eq(:lists)
    end
  end

  describe '.create' do
    let(:params) { ActionController::Parameters.new(list: { name: 'Hello' }) }
    let(:lists) { double('Lists') }
    let(:list) { double('list') }
    subject { ListsFacade.create(user: user, params: params) }

    it 'creates new list from parameters and gets updated user list' do
      expect(ListsFacade).to receive(:lists).and_return(lists)
      expect(ListsFacade).to receive(:create_list).with(params: params, lists: lists).and_return(:list)
      expect(lists).to receive(:reload).and_return(:lists)

      expect(subject.list).to eq(:list)
      expect(subject.lists).to eq(:lists)
    end
  end
end
