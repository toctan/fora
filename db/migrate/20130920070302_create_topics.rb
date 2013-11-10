class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string     :title, null: false
      t.text       :body
      t.text       :body_html
      t.integer    :likes_count,   default: 0
      t.integer    :replies_count, default: 0
      t.string     :last_replier_username
      t.references :user, index: true
      t.references :node, index: true

      t.timestamps
    end
  end
end
