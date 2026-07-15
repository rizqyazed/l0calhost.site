class PagesController < ApplicationController
  unauthenticated_access_only only: :home
  allow_unauthenticated_access only: :directory

  def home
    @user = User.new
  end

  def dashboard
    @site = Current.user.site
    @content_blocks = @site.content_blocks.order(:position)
  end

  def directory
    @users = User.includes(site: :rich_text_description).all
  end
end
