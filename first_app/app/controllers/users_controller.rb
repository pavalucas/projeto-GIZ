class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1.
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Bem-Vindo ao Projeto SACI"
      redirect_to @user
    else
      render 'new'
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Perfil Atualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Você não está logado." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
 

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                    :password_confirmation)
    end
end
