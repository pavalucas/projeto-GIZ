class SessionsController < ApplicationController
	def new
  	end

	def create
	  student = User.find_by(email: params[:session][:email].downcase)
    teacher = Teacher.find_by(email: params[:session][:email].downcase)
    if student && student.authenticate(params[:session][:password])
      sign_in student
      redirect_to student
    elsif teacher && teacher.authenticate(params[:session][:password])
      sign_in teacher
      redirect_to teacher
    else
      flash.now[:error] = 'Senha ou Email inválido'
      render 'new'
    end
  end

  def destroy
  	sign_out
    redirect_to root_url
  end
end