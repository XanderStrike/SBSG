class AddEmailAndPasswordToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :email, :string, unique: true
    add_column :businesses, :password_digest, :string
  end
end
