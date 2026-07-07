class SitesController < ApplicationController
   def create
      @site = Site.new(site_params)
      if @site.save
          CompileSiteJob.perform_later(@site.id)
          redirect_to root_path, notice: "Your site is being compiled! Check back in a few seconds."
      else
          render :new
      end
   end

  def update
    @site = Site.find(params[:id])

    if @site.update(site_params)
      flash[:notice] = "Site updated successfully!"
      redirect_to dashboard_path
    else
      render :edit, status: :unprocessable_entity
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
