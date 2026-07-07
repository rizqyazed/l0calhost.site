# app/jobs/compile_site_job.rb
class CompileSiteJob < ApplicationJob
  queue_as :default

  def perform(site_id)
    site = Site.find(site_id)

    # Compile the HTML file
    file_path = SiteCompiler.new(site).compile!

    file_path
    # Optional: If the user requested a source download, zip the directory here
    # Optional: Upload file_path to Azure Storage for the live site

    # Clean up the local file after uploading if necessary
    # FileUtils.rm_rf(File.dirname(file_path))
  end
end
