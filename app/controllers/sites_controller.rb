class SitesController < ApplicationController
   def create
      @site = Site.new(site_params)
      if @site.save
          # CompileSiteJob.perform_later(@site.id)
          # redirect_to root_path, notice: "Your site is being compiled! Check back in a few seconds."
          redirect_to dashboard_path
      else
          render dashboard_path
      end
   end

  def update
    @site = Site.find(params[:id])

    if params[:site][:folder_upload].present?

      actual_files = params[:site][:folder_upload].reject(&:blank?)

      if actual_files.any?
        process_folder_upload(@site, actual_files)
      end
    end

    if @site.update(site_params)
      flash[:notice] = "Site updated successfully!"
      redirect_to dashboard_path
    else
      render dashboard_path, status: :unprocessable_entity
    end
  end

  def destroy
       Site.find(params[:id]).destroy
       redirect_to root_path
  end

  private

  def site_params
       params.require(:site).permit(:title, :description, folder_upload: [])
  end

  def process_folder_upload(site, uploaded_files)
    # 1. Wipe the old site completely clean
    site.content_blocks.destroy_all

   # 2. Filter out junk files (like Mac's invisible .DS_Store files)
   valid_files = uploaded_files.reject(&:blank?).reject do |file|
      file.original_filename.include?(".DS_Store")
    end

    # 3. Sort files numerically (so 10.txt comes AFTER 2.png, not before it!)
    sorted_files = valid_files.sort_by do |file|
      # file.original_filename looks like "my_folder/1.png"
      filename = file.original_filename.split("/").last
      filename.to_i # Ruby is smart: "1.png".to_i becomes 1, "10.txt".to_i becomes 10!
    end

    # 4. Generate a block for each file
    sorted_files.each do |file|
      filename = file.original_filename.split("/").last
      extension = File.extname(filename).downcase

      block = site.content_blocks.build

      case extension
      when ".txt"
        block.block_type = "text"
        # Physically read the text inside the file and save it as the body
        block.body = file.read
      when ".jpg", ".jpeg", ".png", ".gif"
        block.block_type = "image"

        compressed_file = ImageProcessing::Vips
          .source(file.path)
          .resize_to_limit(1200, 1200)
          .saver(quality: 80)
          .convert("webp")
          .call

        original_name_without_extension = File.basename(filename, File.extname(filename))
        new_filename = "#{original_name_without_extension}.webp"

        block.media_file.attach(
          io: compressed_file,
          filename: new_filename,
          content_type: "image/webp"
        )
      when ".mp3", ".wav"
        block.block_type = "audio"
        block.media_file.attach(file)
      when ".mp4", ".mov"
        block.block_type = "video"
        block.media_file.attach(file)
      else
        # If they upload a weird file type (.pdf, .zip), just skip it
        next
      end

      block.save!
    end
  end
end
