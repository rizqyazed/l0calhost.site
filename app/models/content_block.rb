class ContentBlock < ApplicationRecord
  belongs_to :site

  # The rich text editor for your text blocks
  has_rich_text :body

  # The file attachment for your images/audio/video
  has_one_attached :media_file

  before_save :set_position_from_filename

  private

  def set_position_from_filename
    # Only run this if a file is actually attached and position is empty
    if media_file.attached? && position.nil?
      extracted_number = media_file.filename.to_s[/\d+/]
      self.position = extracted_number ? extracted_number.to_i : 9999
    end
  end
end
