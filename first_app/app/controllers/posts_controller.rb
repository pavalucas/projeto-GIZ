class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :download, :showSubject]

  def create
    @post = current_user.posts.build(post_params)
    @post.group_id = current_user.group_id
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
    @group = Group.find(current_user.group_id)
    @posts = @group.posts.where(subject: params_subject).paginate(page: params[:page])
    @user = current_user
    @post_count = @posts.count
    render 'shared/_group_posts_subjects'
  end

  def home
    #debugger
    if signed_in?
      @post = current_user.posts.build
      @user = current_user
      unless @user.teacher?
        @group = Group.find(current_user.group_id)
        @posts = @group.posts.paginate(page: params[:page])
        @post_count = @posts.count
      else
        @group = Group.all
        @subject = current_user.subject
        for i in 1 .. @group.count
          #Aqui está o problema, desse jeito o @posts não fica com os posts de todas as turmas
          @posts = Group.find(i).posts.where(subject: @subject).paginate(page: params[:page])
        end
        @post_count = @posts.count
      end
      #@user_post = user_post
    end
    render 'static_pages/home'
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