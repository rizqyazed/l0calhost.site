class DashboardsController < ApplicationController
  def show
    @site = Site.find(params[:id])
  end
end
