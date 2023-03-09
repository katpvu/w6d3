class CreateArtworks < ActiveRecord::Migration[7.0]
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.string :image_url, null: false, unique: true
      t.references :artist, null: false, foreign_key: { to_table: :users }
    
      #combination of artist_id and title only appears once
      t.index [:artist_id, :title], unique: true

      t.timestamps
    end

    #add uniqueness to users table - username column
    remove_column :users, :username
    add_column :users, :username, :string, null: false, unique: true
  end
end
