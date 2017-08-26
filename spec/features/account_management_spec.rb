require 'rails_helper'

RSpec.feature 'Account Management', type: :feature do
  fixtures(:users)
  let(:admin) { users(:user_admin) }
  let(:admin_password) { 'password' }
  let(:session_new_alert) { I18n.t('devise.sessions.signed_in') }
  let(:session_destroy_alert) { I18n.t('devise.sessions.signed_out') }

  scenario 'Login and Logout' do
    expect_user_to_be_able_to_navigate_to_login_page
    fill_in_form_as_admin
    expect_user_to_login_and_go_to_root
    expect_user_to_be_able_to_logout
  end

  feature 'Edit Account' do
    let(:new_password) { 'new_password' }
    let(:password_successful) { I18n.t('devise.registrations.updated') }

    before(:each) { sign_in(admin) }

    scenario 'update password' do
      visit root_path
      click_link 'Account'
      expect(page).to have_current_path(edit_user_registration_path)

      fill_in 'Password', with: new_password
      fill_in 'Password confirmation', with: new_password
      fill_in 'Current password', with: admin_password
      click_on 'Update'
      expect(page).to have_current_path(root_path)
      expect(page).to have_selector('.alert-info', text: password_successful)

      click_on 'Logout'
      click_on 'Login'
      fill_in_form_as_admin(new_password)
      expect_user_to_login_and_go_to_root
    end
  end

  feature 'Signup' do
    let(:email_sent) { I18n.t('devise.registrations.signed_up_but_unconfirmed') }
    let(:account_created) { I18n.t('devise.confirmations.confirmed') }

    scenario 'user can signup' do
      visit root_path
      click_on 'Sign up'
      expect(page).to have_current_path(new_user_registration_path)

      fill_in 'Email', with: admin.email + '1'
      fill_in 'Password', with: admin_password
      fill_in 'Password confirmation', with: admin_password
      click_on 'Sign up'
      expect(page).to have_selector('.alert-info', text: email_sent)
      expect(page).to have_current_path(root_path)

      visit generated_link
      expect(page).to have_selector('.alert-info', text: account_created)
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  def expect_user_to_be_able_to_navigate_to_login_page
    visit root_path
    click_on 'Login'
    expect(page).to have_current_path(new_user_session_path)
  end

  def fill_in_form_as_admin(password = admin_password)
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: password
    find('#user_remember_me').click
  end

  def expect_user_to_login_and_go_to_root
    click_on 'Login'
    expect(page).to have_selector('.alert-info', text: session_new_alert)
    expect(page).to have_current_path(root_path)
  end

  def expect_user_to_be_able_to_logout
    click_on 'Logout'
    expect(page).to have_current_path(root_path)
    expect(page).to have_selector('.alert-info', text: session_destroy_alert)
  end

  def generated_link
    ActionMailer::Base.deliveries.last.body.match(/http[^"]*/)
  end
end
