class LoginPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  def visit_page
    visit new_session_path
  end

  def fill_log_in(email, password)
    fill_in "email_address", with: email
    fill_in "password", with: password
  end

  def log_in
    click_button("sign in", wait: 10)
  end
end
