class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user,    index: true
      t.references :reply,   index: true
      t.boolean    :is_read, default: false
      t.belongs_to :mentionable, polymorphic: true, index: true
      t.string     :type

      t.index      :is_read

      t.timestamps
    end
  end
end
