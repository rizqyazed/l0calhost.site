class CreateContentBlocks < ActiveRecord::Migration[8.1]
  def change
    create_table :content_blocks do |t|
      t.references :site, null: false, foreign_key: true
      t.string :block_type

      t.timestamps
    end
  end
end
