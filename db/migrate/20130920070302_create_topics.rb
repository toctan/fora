class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string     :title
      t.text       :body
      t.text       :body_html
      t.integer    :replies_count, default: 0
      t.integer    :last_replier_id
      t.references :user, index: true
      t.references :node, index: true
      t.integer    :active_replier_ids, array: true, default: []

      t.timestamps
    end
  end
end
