class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.string :name, :null => false
      t.string :uid, :null => false
      t.integer :account_id, :null => false
      t.datetime :locked_at, :null => false
      t.timestamps
    end

    add_column :accounts, :token, :string

    add_index :accounts, :token, :uniq => true

    add_index :social_accounts, [:name, :uid], :uniq => true
    add_index :social_accounts, :account_id
  end
end
