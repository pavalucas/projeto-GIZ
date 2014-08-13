module GroupsHelper
	def current_group
    	#remember_token = Group.digest(cookies[:remember_token])
    	@current_group ||= Group.find_by(name: "Turma 302")
    	@posts = @current_group.posts.paginate(page: params[:page])
  	end

    def current_group?(group)
      group == current_group
    end
end
