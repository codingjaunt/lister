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
    let(:successfully_created_list) { 'List was succesfully created' }
    let(:duplicate_name) { 'Name has already been taken' }

    before(:each) do
      sign_in user
      visit root_path
    end

    scenario 'has expected components' do
      expect(page).to have_selector('.lister-personal-section .lister-list-create')
    end

    scenario 'can create and delete a list', js: true do
      expect { creating_list_w_validations(name: 'Hello', notice: successfully_created_list) }
        .to change { list_item_count }.by(1)

      expect { deleting_list_w_validations }
        .to change { list_item_count }.by(-1)
    end

    scenario 'cannot create duplicate class names', js: true do
      expect { creating_list_w_validations(name: List.first.name, warning: duplicate_name) }
        .to change { list_item_count }.by(0)
    end
  end

  def creating_list_w_validations(name:, notice: nil, warning: nil)
    msg = notice || warning
    type = notice ? :info : :warning
    fill_in 'list[name]', with: name
    click_on 'Submit'
    expect(page).to have_selector(".alert-#{type} p", text: msg)
    expect(find('input[name="list[name]"]').value).to be_empty
  end

  def list_item_count
    all('.lister-list-item').count
  end

  def deleting_list_w_validations
    find('.lister-list-item', match: :first).click_link('Delete')
    page.accept_alert
    expect(page).to have_selector('.alert-info p', text: 'List was deleted')
  end
end
