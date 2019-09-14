class UsersController < ApplicationController
	def new
	end

	def index
		@user = User.all
		@post = Book.new
	end

	def edit
	end

	def show
		@user = User.find(params[:id])
		@post = Book.new
		@books = @user.books
	end

	def users
	end
end
