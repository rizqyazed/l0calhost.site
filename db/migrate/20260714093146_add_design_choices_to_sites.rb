class AddDesignChoicesToSites < ActiveRecord::Migration[8.1]
  def change
    add_column :sites, :layout_choice, :string, default: "basic"
    add_column :sites, :theme_choice, :string, default: "classic"
  end
end
