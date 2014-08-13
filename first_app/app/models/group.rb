class Group < ActiveRecord::Base
	has_many :users
	has_many :posts
	validates :name, presence: true, length: { maximum: 25 }, uniqueness: true

	def User.new_remember_token
    SecureRandom.urlsafe_base64
  	end

	private
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
