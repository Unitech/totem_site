class Pin < ActiveRecord::Base
	acts_as_votable
	acts_as_taggable
	belongs_to :admin, class_name: 'User'
  has_many :participations
  has_many :participants, through: :participations

	has_attached_file :image, styles: {medium: "300x300>"}
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def has_participant(user)
    participants.exists?(user.id)
  end
end
