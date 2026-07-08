class AddUserIdToSites < ActiveRecord::Migration[8.1]
  def change
    add_reference :sites, :user, null: false, foreign_key: true
  end
end
