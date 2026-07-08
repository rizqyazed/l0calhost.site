class PagesController < ApplicationController
  unauthenticated_access_only only: :home
  allow_unauthenticated_access only: :directory

  def home
    @user = User.new
  end

  def dashboard
    @site = Current.user.site
  end

  def directory
    @users = User.all
  end
end
