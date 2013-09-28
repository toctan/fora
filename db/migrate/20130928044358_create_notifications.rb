class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user,    index:   true
      t.references :topic,   index:   true
      t.boolean    :is_read, default: false
      t.integer    :actor_id
      t.text       :data

      t.timestamps
    end
  end
end
