class AddPersistentSessionDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :persistent_session_digest, :string
  end
end
