class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :target, index: true
      t.references :source, index: true
      t.references :topic,  index: true
      t.references :reply,  index: true
      t.references :like,   index: true
      t.boolean    :is_read, default: false
      t.string     :kind, null: false

      t.index      :is_read

      t.timestamps
    end
  end
end
