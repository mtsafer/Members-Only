module SessionsHelper

	def login user
		session[:user_id] = user.id
	end

	def logged_in?
		!session[:user_id].nil?
	end

	def logout
		forget current_user
		session.delete(:user_id)
		@current_user = nil
	end

	def current_user
		if( user_id = session[:user_id] )
			@current_user ||= User.find_by_id(user_id)
		end
	end

	# Forgets a persistant user
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

end
