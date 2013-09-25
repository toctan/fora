class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :body
      t.references :user,  index: true
      t.references :topic, index: true

      t.timestamps
    end
  end
end