class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string  :name
      t.string  :key
      t.string  :description
      t.integer :topics_count, default: 0
      t.attachment :image

      t.timestamps
    end

    add_index :nodes, :key, unique: true
  end
end
