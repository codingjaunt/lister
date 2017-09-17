require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#flash_messages' do
    it 'return an empty array when given nil' do
      expect(helper.flash_messages(nil)).to eq([])
    end

    it 'returns an array of string passed in' do
      expect(helper.flash_messages('Message')).to eq(['Message'])
    end

    it 'returns an array if an array is passed in' do
      expect(helper.flash_messages(%w[An Array])).to eq(%w[An Array])
    end
  end
end
