class AddDigestTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authentication_digest, :string
  end
end
