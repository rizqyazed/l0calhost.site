class Site < ApplicationRecord
  AVAILABLE_LAYOUTS = %w[basic center].freeze
  AVAILABLE_THEMES = %w[classic modern dark terminal].freeze

  belongs_to :user

  has_many :content_blocks, dependent: :destroy

  has_rich_text :description

  validates :layout_choice, inclusion: { in: AVAILABLE_LAYOUTS }
  validates :theme_choice, inclusion: { in: AVAILABLE_THEMES }

  attr_accessor :folder_upload
end
