class BooksController < ApplicationController
  
  before_action :authenticate_user!


  def index
    @books = Book.all
    @book = Book.new
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
  	  redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @posts = Book.find(params[:id])
    @user = @posts.user
    @post = Book.new
  end

  def edit
   @post = Book.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @post = Book.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to books_path
   end
    if @post.update!(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@post.id)
    else
      render action: :edit
    end
  end

  def destroy
    @post = Book.find(params[:id])
    @post.destroy
    redirect_to books_path
  end

  def search
    @books = Book.search(params[:search])
    @book = Book.new
    render "index"
  end


  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end
