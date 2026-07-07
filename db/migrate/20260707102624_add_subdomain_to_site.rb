class AddSubdomainToSite < ActiveRecord::Migration[8.1]
  def change
    add_column :sites, :subdomain, :string
  end
end
