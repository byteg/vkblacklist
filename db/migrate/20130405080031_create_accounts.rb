class CreateAccounts < ActiveRecord::Migration

  def change
    create_table :accounts do |t|
      t.string :ban_url
      t.string :unban_url
      t.timestamps
    end
  end
  
end
