# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
    validates :image_url, presence: true, uniqueness: true
    validates :artist_id, uniqueness: { scope: :title }
    validates :title, :artist_id, presence: true

    belongs_to :artist,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: :User

    has_many :artwork_shares,
        foreign_key: :artwork_id,
        class_name: :ArtworkShare

    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer

    def self.artworks_for_user_id(input_id)
        shared = Artwork.joins(:artwork_shares).where('viewer_id = ?', input_id)
        artworks = Artwork.where('artist_id = ?', input_id)
        return shared, artworks
    end
end
