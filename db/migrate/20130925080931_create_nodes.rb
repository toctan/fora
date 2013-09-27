class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string  :name
      t.string  :key
      t.string  :description
      t.integer :topics_count, default: 0

      t.timestamps
    end
  end
end
