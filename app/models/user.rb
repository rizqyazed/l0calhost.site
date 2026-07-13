class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :site, dependent: :destroy

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 63, too_short: "username is too short (minimum is %{count} characters)",
              too_long: "username is too long (maximum is %{count} characters)"
            },
            format: {
              with: /\A[a-z0-9][a-z0-9\-]*[a-z0-9]\z/,
              message: "can only contain lowercase letters, numbers, and hyphens, and cannot start or end with a hyphen"
            }

  validates :email_address,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
              message: "must be a valid email address"
            }


  before_validation :downcase_username

  after_create :generate_blank_site

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  private

  def generate_blank_site
    create_site!()
  end

  def downcase_username
    self.username = username.downcase if username.present?
  end
end
