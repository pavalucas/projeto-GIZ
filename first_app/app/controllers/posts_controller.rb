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

  private

    def post_params
      params.require(:post).permit(:content, :group_id,:photo)
    end

    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Você não está logado." unless signed_in?
    end
end