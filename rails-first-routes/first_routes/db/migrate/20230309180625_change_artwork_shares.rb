class ChangeArtworkShares < ActiveRecord::Migration[7.0]
  def change
    drop_table :artwork_shares
  end
end
