class Site < ApplicationRecord
  belongs_to :user

  has_many :content_blocks, dependent: :destroy

  attr_accessor :folder_upload
end
