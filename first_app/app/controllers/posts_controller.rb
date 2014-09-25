class PostsController < ApplicationController
  before_action :signed_in_user

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post criado!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  def download 
    @post = current_user.posts.find(params_photo_id)
    send_file @post.photo.path, 
      :type => @post.photo_content_type,
      :disposition => 'inline' 
  end

  def showSubject
    #debugger
    @posts = current_user.posts.where(subject: params_subject).paginate(page: params[:page])
    @user = current_user
    @post_count = @posts.count 
    render 'shared/_user_posts'
  end

  private

    def post_params
      params.require(:post).permit(:content, :group_id, :photo, :subject)
    end

    def params_photo_id
      #debugger
      params.require(:id)
    end

    def params_subject
      #debugger
      params.require(:subject)
    end

    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Você não está logado." unless signed_in?
    end
end