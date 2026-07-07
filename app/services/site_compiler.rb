require "fileutils"

class SiteCompiler
  def initialize(site)
    @site = site
  end

  def compile!
    # 1. Gather data exactly like a controller would
    # content_blocks = @site.content_blocks.order(position: :asc)

    # 2. Render the ERB template to a plain string using ApplicationController
    html_content = ApplicationController.render(
      template: "exports/theme1",
      layout: false, # We don't want your main dashboard layout wrapper
      assigns: { site: @site } # Passes data into @site and @content_blocks
    )

    # 3. Create a unique temporary directory on your server
    dir_path = Rails.root.join("tmp", "exports", "site_#{@site.id}")
    FileUtils.mkdir_p(dir_path)

    # 4. Write the string into an index.html file
    file_path = File.join(dir_path, "index.html")
    File.write(file_path, html_content)

    # Return the file path so your background job knows where it is
    file_path
  end
end
