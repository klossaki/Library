class BorrowsController < ApplicationController
  
  def new
    @number_of_books_borrowed = Borrow.where(:user_id => current_user.id)
    @number_of_books_not_returned = @number_of_books_borrowed.select{|borrow| borrow.returned == false }.size
    if @number_of_books_not_returned <= 3
      @current_date = Date.today
      @date_of_return = Date.today+1.month
      @borrowed_book = Borrow.new(:user_id => params[:user_id], :book_id => params[:book_id], :date_of_borrow => @current_date, :date_of_return => @date_of_return)
      if @borrowed_book.save
        flash[:notice] = "Book has been successfully borrowed"
        @book = Book.find(@borrowed_book.book_id)
        copies = @book.copies
        copies -= 1
        Book.update(@borrowed_book.book_id, :copies => copies)
        redirect_to @borrowed_book   
      else
        flash[:notice] = "Error: The book could not be borrowed!"
        redirect_to controller: :books, action: :view_books
      end
    else
      redirect_to controller: :welcom, action: :index
    end
  end
  
  def show
    @borrowed_book = Borrow.find(params[:id])
  end
  
  def index_by_user    
    borrows_not_returned = Borrow.where(:user_id => current_user.id, :returned => false )
    total_number_of_borrows_not_returned = borrows_not_returned.count
    @borrows_not_returned = borrows_not_returned.paginate(page: params[:page], per_page: 10, :total_entries => total_number_of_borrows_not_returned)
    borrows_returned = Borrow.where(:user_id => current_user.id, :returned => true )
    total_number_of_borrows_returned = borrows_returned.count
    @borrows_returned = borrows_returned.paginate(page: params[:page], per_page: 10, :total_entries => total_number_of_borrows_returned)
  end

  def index
    borrows_not_returned = Borrow.where(:returned => false)
    total_number_of_borrows_not_returned = borrows_not_returned.count
    @borrows_not_returned = borrows_not_returned.paginate(:page => params[:borrows_not_returned_page], :per_page => 10, :total_entries => total_number_of_borrows_not_returned)
    borrows_returned = Borrow.where(:returned => true)
    total_number_of_borrows_returned = borrows_returned.count
    @borrows_returned = borrows_returned.paginate(:page => params[:borrows_returned_page], :per_page => 10, :total_entries => total_number_of_borrows_returned)
  end
  
  def return_book
    @borrow = Borrow.find(params[:borrow_id])
    @borrow.returned = true
    @book = Book.find(@borrow.book_id)
    @book.copies +=1
    if ((@book.save) && (@borrow.save))
      @books = Book.all
      redirect_to borrows_path(@books)
      flash[:notice] = "Book successfully returned"
    else
      redirect_to borrows_path(@books)
      flash[:notice] = "An error occured while returning the book"
    end
  end

  def sendemail  
    @user = User.find(params[:user_id])
    @book = Book.find(params[:book_id])
    UserMailer.notification_mail(@user, @book).deliver  
    redirect_to borrows_path  
    flash[:notice] = 'Email has been sent!'  
  end  
  
end
