class CreateJoinTableUsersArtworks < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :artworks, table_name: :artwork_shares 
      # t.index [:user_id, :artwork_id]
      # t.index [:artwork_id, :user_id]
    # end
  end
end

# rails g model AssignmentSecurityUser assignments_security:references user:references