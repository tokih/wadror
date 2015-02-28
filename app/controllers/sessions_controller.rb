class SessionsController < ApplicationController
	def new

	end

	def create_oauth
		user = User.find_by username: env["omniauth.auth"].info.nickname
		if user && not(user.locked)
			session[:user_id] = user.id
			redirect_to user_path(user), notice: 'Welcome back!'
		else
			redirect_to signin_path, notice: 'Invalid username or account is locked'
		end

	end

	def create
		user = User.find_by username: params[:username]
		if user && user.authenticate(params[:password])
			unless user.locked
				session[:user_id] = user.id
				redirect_to user_path(user), notice: "Welcome back!"
			else
				redirect_to signin_path, notice: 'Your account is locked'
			end
		else
			redirect_to :back, notice: "Username and/or password mismatch"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to :root
	end
end
