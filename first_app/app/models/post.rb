class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :group_id, presence: true
	validates :content, presence: true
	has_attached_file :photo,
		:path => ":rails_root/uploads/:class/:id/:basename.:extension",
		:url => "/photos/:id/download"
	validates_attachment_content_type :photo, :content_type => 
	['image/jpg','image/jpeg','image/pjpeg','image/png','image/x-png',
		'image/gif','text/plain','application/mspowerpoint','application/vnd.ms-powerpoint',
		'application/vnd.openxmlformats-officedocument.presentationml.presentation', 
		'application/msexcel','application/vnd.ms-excel',
		'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
		'application/pdf','application/msword', 
		'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ]
	validates_attachment_size :photo, :less_than => 5.megabytes
end
