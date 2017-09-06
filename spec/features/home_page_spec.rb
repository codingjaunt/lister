require 'rails_helper'

RSpec.feature 'HomePage', type: :feature do
  feature 'vistor' do
    scenario 'has expected components' do
      visit root_path

      expect(page).to have_title('Home | Lister')
      expect(page).to have_selector('nav', text: 'Lister')
      expect(page).to have_selector('nav a', text: 'Login')
      expect(page).to have_selector('main #about')
      expect(page).to have_selector('main .signup.btn', text: 'Sign up')
      expect(page).to have_selector("footer a[href='https://github.com/codingjaunt/']")
      expect(page).to have_selector("footer a[href='www.codingjaunt.com']")
    end
  end

  feature 'user' do
    fixtures(:users)
    let(:user) { users(:santa) }

    before(:each) do
      sign_in user
      visit root_path
    end

    scenario 'has expected components' do
      expect(page).to have_selector('.lister-personal-section .lister-list-create')
    end

    scenario 'can create new list', js: true do
      fill_in 'list[name]', with: 'Hello'
      expect do
        click_on 'Submit'
      end.to change { ListsFacade.lists(user: user.reload).size }.by(1)
      expect(find('input[name="list[name]"]').value).to be_empty
    end
  end
end
