class PublicSitesController < ApplicationController
  allow_unauthenticated_access

  def show
    @site = Site.find_by!(subdomain: request.subdomain)

    # note for future self. can use @site.theme here to access different themes/layout for user.
    render layout: "theme1"
  end
end
