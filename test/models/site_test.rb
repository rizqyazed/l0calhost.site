require "test_helper"

class SiteTest < ActiveSupport::TestCase
  setup do
    @site = sites(:one)
  end
  test "site can only exists when there is a user" do
    user = users(:one)
    site = Site.new(user: user, title: "title", description: "desc")
    assert(site.valid?)

    site.user = nil
    assert_not(site.valid?)
  end

  test "can upload a file to site" do
    file_path = Rails.root.join("test", "fixtures", "files", "folder1/1.jpg")

    block = @site.content_blocks.build

    block.media_file.attach(
      io: File.open(file_path),
      filename: "1.jpg",
      content_type: "image/jpeg"
    )

    assert block.media_file.attached?
    assert_equal "1.jpg", block.media_file.filename.to_s
  end

  test "only choose from preselected themes and layouts" do
    user = users(:one)
    site = Site.new(user: user, title: "title", description: "desc", theme_choice: "this_theme_doesnt_exists")

    assert_not(site.valid?)

    site.theme_choice = "classic"

    assert_equal "classic", site.theme_choice
    assert(site.valid?)
  end

  test "default themes and layout for site" do
    user = users(:one)
    site = Site.new(user: user, title: "title", description: "desc")

    assert_equal "basic", site.layout_choice
    assert_equal "classic", site.theme_choice
  end
end
