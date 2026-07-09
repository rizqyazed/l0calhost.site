class ContentBlock < ApplicationRecord
  belongs_to :site

  # The rich text editor for your text blocks
  has_rich_text :body

  # The file attachment for your images/audio/video
  has_one_attached :media_file
end
