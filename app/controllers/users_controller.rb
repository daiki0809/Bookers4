class UsersController < ApplicationController
	def new
	end

	def index
		@user = User.all
		@post = Book.new
	end

	def edit
		@user = current_user
	end

	def update
		user = current_user
		user.update(user_params)
		redirect_to user_path(current_user.id)
	end

	def show
		@user = User.find(params[:id])
		@post = Book.new
		@books = @user.books
	end

	def users
	end

	private

	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end
end
