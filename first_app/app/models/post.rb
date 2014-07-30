class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
	default_scope -> { order('created_at DESC') }
  	validates :user_id, presence: true
  	validates :group_id, presence: true
  	validates :content, presence: true
  	has_attached_file :photo
  	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  	validates_attachment_size :photo, :less_than => 5.megabytes
end
