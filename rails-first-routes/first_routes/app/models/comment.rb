# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  commenter_id :bigint           not null
#  artwork_id   :bigint           not null
#  body         :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Comment < ApplicationRecord
    validates :body, :commenter_id, :artwork_id, presence: true

    belongs_to :commenter,
        foreign_key: :commenter_id,
        class_name: :User

    belongs_to :artwork,
        foreign_key: :artwork_id,
        class_name: :Artwork

    has_many :likes, as: :likeable

    def self.comments_from_user_id(input_id)
        Comment.joins(:commenter).where('users.id = ?', input_id)
    end

    def self.comments_on_artwork_id(input_id)
        Comment.joins(:artwork).where('artworks.id = ?', input_id)
    end
end
