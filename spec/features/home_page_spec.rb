require 'rails_helper'

RSpec.feature "HomePage", type: :feature do
  scenario "has expected components" do
    visit root_path

    expect(page).to have_title("Home | Lister")
    expect(page).to have_selector("header", text: "Lister")
    expect(page).to have_selector("header .btn", text: "Login")
    expect(page).to have_selector("main #about")
    expect(page).to have_selector("main #signup .btn", text: "Sign up")
    expect(page).to have_selector("footer a[href='https://github.com/codingjaunt/']")
    expect(page).to have_selector("footer a[href='www.codingjaunt.com']")
  end
end
