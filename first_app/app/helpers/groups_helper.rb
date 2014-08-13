module GroupsHelper
	def current_group
    	remember_token = Group.digest(cookies[:remember_token])
    	@current_group ||= Group.find_by(remember_token: remember_token)
  	end

    def current_user?(group)
      group == current_group
    end
end
