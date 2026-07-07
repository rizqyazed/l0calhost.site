class PagesController < ApplicationController
  unauthenticated_access_only only: :home
  allow_unauthenticated_access only: :directory

  def home
    @user = User.new
  end

  def dashboard
    @site = Site.find(params[:id])
  end

  def directory
    @sites = Site.all
  end
end
