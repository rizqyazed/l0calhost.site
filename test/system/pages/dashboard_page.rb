class DashboardPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  def visit_page
    visit dashboard_path
  end

  def fill_basic_info(title, summary)
    fill_in "site_title", with: title
    fill_in "site_description", with: summary
  end

  def has_basic_info?(expected_title, expected_summary)
    has_field?("site_title", with: expected_title)
    has_field?("site_description", with: expected_summary)
  end

  def publish_site
    click_button "publish"
  end

  def view_live_site(username)
    click_link "#{username}.lvh.me"
  end

  def has_published_message?
    has_text?("site updated successfully!", wait: 10)
  end

  def upload_site(folder_name)
    folder_path = Rails.root.join("test", "fixtures", "files", folder_name)

    attach_file("site[folder_upload][]", folder_path.to_s)
  end
end
