class BooksController < ApplicationController
  
  def index
    @books = Book.paginate(page: params[:page], per_page: 10)
    authorize! :update, @books
  end

  def view_books
    @books = Book.paginate(page: params[:page], per_page: 10)
    authorize! :read, @books
    number_of_books_borrowed = Borrow.where(:user_id => current_user.id)
    @number_of_books_not_returned = number_of_books_borrowed.select{|borrow| borrow.returned == false }.size
  end
  
  def new
    @book = Book.new
    authorize! :create, @book
  end

  def create
    @book = Book.new(book_params)
    authorize! :create, @book
    if @book.save
      flash[:notice] = "Book successfully created"
    else
      flash[:notice] = "Book could not be created"
    end
    redirect_to action: :index
  end
  
  def update
    @book = Book.find(params[:id])
    authorize! :update, @book
    if @book.update!(book_params)
      flash[:notice] = "Book successfully updated"
      redirect_to @book
    else
      flash[:notice] = "The book could not be updated"
      render 'edit'
    end
  end
  
  def update_book_rank
    @book = Book.find(params[:id])
    authorize! :read, @book
    @book.rank = params[:rank]
    if @book.update!(book_params)
      flash[:notice] = "Book successfully ranked"
      redirect_to view_books_books_path
    else
      flash[:notice] = "Book could not be ranked"
      render 'edit'
    end
  end
  
  def rank_book
    @book = Book.find(params[:id])
    authorize! :read, @book
  end
  
  def edit
    @book = Book.find(params[:id])
    authorize! :update, @book
  end
  
  def destroy
    @book = Book.find(params[:id])
    authorize! :destroy, @book
    if @book.destroy
      flash[:notice] = "Book successfully deleted"
    else
      flash[:notice] = "Book could not be deleted"
    end
    redirect_to books_path
  end

  def show
    @book = Book.find(params[:id])
    authorize! :read, @book
  end
  
  def search_by_title
    @book = Book.new
    authorize! :read, @book
  end
  
  def show_search_by_title
    q = params[:book][:title]
    books = Book.where('title LIKE ?', "%#{q}%")
    @books = books.paginate(page: params[:page], per_page: 10)
    authorize! :read, @books
    number_of_books_borrowed = Borrow.where(:user_id => current_user.id)
    @number_of_books_not_returned = number_of_books_borrowed.select{|borrow| borrow.returned == false }.size
  end
  
  
  private

  def book_params
    params.require(:book).permit(:title, :isbn, :author_id, :cat_id, :copies, :rank)
  end
  

end

