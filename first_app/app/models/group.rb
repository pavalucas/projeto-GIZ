class Group < ActiveRecord::Base
	has_many :users
	has_many :posts
	validates :name, presence: true, length: { maximum: 25 }, uniqueness: true
end
