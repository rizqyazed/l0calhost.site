class SitesController < ApplicationController
   def create
      @site = Site.new(site_params)
      if @site.save
          # CompileSiteJob.perform_later(@site.id)
          # redirect_to root_path, notice: "Your site is being compiled! Check back in a few seconds."
          redirect_to dashboard_path
      else
          render dashboard_path, status: :unprocessable_entity
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
      flash[:notice] = "site updated successfully!"
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
    site.content_blocks.destroy_all

   valid_files = uploaded_files.reject(&:blank?).reject do |file|
      file.original_filename.include?(".DS_Store")
    end

    sorted_files = valid_files.sort_by do |file|
      filename = file.original_filename.split("/").last
      filename.to_i
    end

    sorted_files.each do |file|
      filename = file.original_filename.split("/").last
      extension = File.extname(filename).downcase

      block = site.content_blocks.build

      case extension
      when ".txt"
        block.block_type = "text"
        block.media_file.attach(file)
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
        next
      end

      block.save!
    end
  end
end
