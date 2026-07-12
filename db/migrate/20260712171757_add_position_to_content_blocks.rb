class AddPositionToContentBlocks < ActiveRecord::Migration[8.1]
  def change
    add_column :content_blocks, :position, :integer
  end
end
