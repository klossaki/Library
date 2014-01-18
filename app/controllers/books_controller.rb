class BooksController < ApplicationController
  def index
    @books = Book.all
  end
  
  def new
  end

  def create
    @book = Book.new(book_params)
    @book.save
    redirect_to action: :index
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update!(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  def show
    @book = Book.find(params[:id])
  end
  
  
  private
  def book_params
    params.require(:book).permit(:title, :isbn, :author_id, :cat_id, :copies, :rank)
  end
  
end
