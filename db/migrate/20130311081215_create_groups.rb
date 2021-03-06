class CreateGroups < ActiveRecord::Migration

  def change
    create_table :groups do |t|
      t.string :url, :null => false
      t.string :title, :null => false
      t.string :name, :null => false
      t.integer :item_id, :null => false
      t.boolean :checked, :default => false
      t.datetime :ban_until, :null => false
      t.integer :ban_reason
      t.boolean :banned
      t.integer :complaints_count, :default => 0
      t.timestamps
    end
    add_index :groups, :item_id, :uniq => true

  end

end
