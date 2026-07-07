class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :site, dependent: :destroy

  after_create :generate_blank_site

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  private

  def generate_blank_site
    create_site!()
  end
end
