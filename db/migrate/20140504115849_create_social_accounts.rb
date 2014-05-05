class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.string :name, :null => false
      t.string :uid, :null => false
      t.integer :account_id
      t.datetime :locked_at
      t.timestamps
    end

    add_column :accounts, :token, :string
    add_index :accounts, :token, :unique => true

    add_index :social_accounts, [:name, :uid], :unique => true
    add_index :social_accounts, :account_id
  end
end
