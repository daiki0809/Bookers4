class BooksController < ApplicationController
  def top
  end

  def index
    @posts = Book.all
    @post = Book.new
  end

  def create
  	post = Book.new(post_params)
    post.user_id = current_user.id
  	post.save
  	redirect_to book_path(post.id)
  end

  def show
    @posts = Book.find(params[:id])
    @user = @posts.user
    @post = Book.new
  end

  def edit
    @post = Book.find(params[:id])
  end

  def update
    @post = Book.find(params[:id])
    @post.update(post_params)
    redirect_to book_path(@post.id)
  end

  def destroy
    @post = Book.find(params[:id])
    @post.destroy
    redirect_to books_path
  end


  private
  def post_params
  	params.require(:book).permit(:title, :body)
  end
end
