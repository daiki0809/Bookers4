class BooksController < ApplicationController
  def top
  end

  def create
  	post = Book.new(post_params)
    post.user_id = current_user.id
  	post.save
  	redirect_to users_path
  end

  private
  def post_params
  	params.require(:book).permit(:title, :body)
  end
end
