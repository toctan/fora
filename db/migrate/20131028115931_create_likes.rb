class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, index: true
      t.belongs_to :likeable, polymorphic: true, index: true

      t.index ['user_id', 'likeable_id', 'likeable_type'], unique: true

      t.timestamps
    end
  end
end
