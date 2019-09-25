class UsersController < ApplicationController
	
	before_action :authenticate_user!


	def new
	end

	def index
		@user = User.all
		@post = Book.new
	end

	def edit
		@user = User.find(params[:id])
		if @user.id != current_user.id
			redirect_to user_path(current_user.id)
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.id != current_user.id
			redirect_to user_path(current_user.id)
		end
		if @user.update(user_params)
			flash[:ok] = "You have updated user successfully"
			redirect_to user_path(current_user.id)
		else
			render action: :edit
		end

	end

	def show
		@user = User.find(params[:id])
		@post = Book.new
		@books = @user.books
	end

	def users
	end

	def following
		@post = Book.new
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.following
		render 'show_follow'
	end

	def followers
		@post = Book.new
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers
		render 'show_follow'
	end

	private

	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end
end
