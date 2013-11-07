class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string  :name, null: false
      t.string  :key,  null: false
      t.string  :color
      t.string  :description
      t.integer :topics_count, default: 0
      t.attachment :image

      t.timestamps
    end

    add_index :nodes, :key, unique: true
  end
end
