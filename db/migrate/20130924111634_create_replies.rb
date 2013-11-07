class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :body,      null: false
      t.text :body_html, null: false
      t.references :user,  index: true
      t.references :topic, index: true

      t.timestamps
    end
  end
end
