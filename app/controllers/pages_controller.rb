class PagesController < ApplicationController
  def home
    @sites = Site.all
    @site = Site.new()
  end

  def dashboard
    @site = Site.find(params[:id])
  end
end
