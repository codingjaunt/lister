require 'rails_helper'

RSpec.feature "HelloWorld", type: :feature do
  scenario "says hello" do
    visit root_path
  end
end
