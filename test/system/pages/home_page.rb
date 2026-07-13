class HomePage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  def visit_page
    visit root_path
    self
  end

  def fill_sign_in(username, email, password)
    fill_in "username", with: username
    fill_in "email", with: email
    fill_in "password", with: password
  end

  def sign_in
    click_button "create website"
  end
end
