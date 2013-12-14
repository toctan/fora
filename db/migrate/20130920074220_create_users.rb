class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :uid
      t.string     :username
      t.string     :provider
      t.string     :remember_token
      t.boolean    :admin, null: false, default: false
      t.attachment :avatar

      t.integer    :replies_count, default: 0
      t.integer    :topics_count,  default: 0
      t.integer    :bookmarks,     default: [], array: true

      t.timestamps
    end

    add_index :users, :remember_token
    add_index :users, :username, unique: true
    add_index :users, [:provider, :uid], unique: true
  end
end
