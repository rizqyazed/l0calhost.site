class SitesController < ApplicationController
   def create
      @site = Site.new(site_params)
      if @site.save
          redirect_to root_path
      else
          render :new
      end
   end

   def destroy
       Site.find(params[:id]).destroy
       redirect_to root_path
   end

   private
   def site_params
       params.require(:site).permit(:title, :description, :subdomain)
   end
end
