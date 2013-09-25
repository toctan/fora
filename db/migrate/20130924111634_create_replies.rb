class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :body
      t.references :user
      t.references :topic

      t.timestamps
    end
  end
end
