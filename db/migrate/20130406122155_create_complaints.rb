class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.integer :account_id, :null => false
      t.string :url, :null => false
      t.integer :group_id, :null => false
      t.string :comment 
      t.timestamps
    end
  end
end
