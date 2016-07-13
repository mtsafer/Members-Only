class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			login user
			remember user if params[:session][:remember_me] == "1"
			flash[:success] = "Welcome back, #{user.name}"
			redirect_to root_path
		else
			flash.now[:danger] = "The password/email combination was invalid."
			render :new
		end
	end

	def destroy
		flash[:success] = "Goodbye!"
		logout if logged_in?
		redirect_to root_path
	end

end
