class PagesController < ApplicationController
  def home
    @sites = Site.all
    @site = Site.new()
  end
end
