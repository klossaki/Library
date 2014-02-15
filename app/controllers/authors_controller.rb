class AuthorsController < ApplicationController

  
  def index
    @authors = Author.paginate(page: params[:page], per_page: 10)
    authorize! :read, @authors
  end
  
  def new
    @author = Author.new
    authorize! :create, @author
  end
  
  def edit
    @author = Author.find(params[:id])
    authorize! :update, @author
  end
  
  def create
    @author = Author.new(author_params)
    authorize! :create, @author
    if @author.save
      flash[:notice] = "Author successfully created"
      redirect_to action: :index
    else
      flash[:notice] = "Author could not be created"
      redirect_to action: :index
    end
  end
  
  def update
    @author = Author.find(params[:id])
    authorize! :update, @author
    if @author.update!(author_params)
      flash[:notice] = "Author successfully updated"
      redirect_to @author
    else
      flash[:notice] = "Author could not be updated"
      render 'edit'
    end
  end
    
  def show
    @author = Author.find(params[:id])
    authorize! :read, @author
  end
  
  def search_by_author
    @author = Author.new
    authorize! :read, @author
  end
  
  def show_search_by_author
    q = params[:author][:id]
    @author = Author.where('id LIKE ?', "%#{q}%")
    books = Book.where(:author_id => @author)
    @books = books.paginate(page: params[:page], per_page: 10)
    authorize! :read, @books
    number_of_books_borrowed = Borrow.where(:user_id => current_user.id)
    @number_of_books_not_returned = number_of_books_borrowed.select{|borrow| borrow.returned == false }.size
  end
  
  
  def destroy
    @author = Author.find(params[:id])
    authorize! :destroy, @author
    if @author.destroy
      flash[:notice] = "Author successfully deleted"
    else
      flash[:notice] = "Author could not be deleted"
    end
    redirect_to authors_path
  end

  
  def view_authors
    @authors = Author.paginate(page: params[:page], per_page: 10)
    authorize! :read, @author
  end
  
  private
  
  def author_params
    params.require(:author).permit(:name)
  end
  
end
