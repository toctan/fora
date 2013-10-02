class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string     :title
      t.text       :body
      t.text       :body_html
      t.integer    :replies_count, default: 0
      t.references :user, index: true
      t.references :node, index: true

      t.timestamps
    end
  end
end
