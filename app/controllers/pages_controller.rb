class PagesController < ApplicationController
  def home
    @site = Site.new()
  end
end
