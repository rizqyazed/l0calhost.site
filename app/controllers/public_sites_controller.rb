class PublicSitesController < ApplicationController
  allow_unauthenticated_access

  def show
    @site = User.find_by!(username: request.subdomain).site

    # note for future self. can use @site.theme here to access different themes/layout for user.
    render layout: "theme1"
  end
end
