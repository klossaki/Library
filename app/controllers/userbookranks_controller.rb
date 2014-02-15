class UserbookranksController < ApplicationController
  
  def new
    @book = Book.find(params[:book_id])
    @user = User.find(params[:user_id])
    @userbookrank = Userbookrank.new
  end
  
  def create
    @userbookrank = Userbookrank.new(userbookrank_params)
    if ((@userbookrank.rank > 10) || (@userbookrank.rank < 0))
      flash[:alert] = "Please enter a number between 0 and 10"
      @userbookrank.rank = 0
      redirect_to view_books_books_path
    else
      if @userbookrank.save
        book_id = @userbookrank.book_id
        book = Book.find(book_id)
        sum_of_ranks = Userbookrank.sum(:rank, :conditions => {:book_id => book.id})
        number_of_ranks = Userbookrank.where(:book_id => book.id).count
        if number_of_ranks!=0 
          book.rank = sum_of_ranks / number_of_ranks
          book.save
          flash[:notice] = "Book successfully ranked"
        end
        redirect_to userbookrank_path(@userbookrank)
      else
        flash[:notice] = "Error!! Book cannot be ranked more than once by the same user!"
        redirect_to view_books_books_path
      end
    end
  end

  def show
    @userbookrank = Userbookrank.find(params[:id])
  end
  
  
  private
  
  def userbookrank_params
    params.require(:userbookrank).permit(:user_id, :book_id, :rank)
  end
  
end
