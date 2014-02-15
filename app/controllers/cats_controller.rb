class CatsController < ApplicationController

  
  def index
    @cats = Cat.paginate(page: params[:page], per_page: 10)
    authorize! :update, @cats
  end
  
  def new
    @cat = Cat.new
    authorize! :create, @cat
  end
  
  def create
    @cat = Cat.new(cat_params)
    authorize! :create, @cat
    if @cat.save
      flash[:notice] = "Category successfully created"
    else
      flash[:notice] = "Category could not be created"
    end
    redirect_to action: :index
  end
  
  def edit
    @cat = Cat.find(params[:id])
    authorize! :edit, @cat
  end
 
  def update
    @cat = Cat.find(params[:id])
    authorize! :update, @cat
    if @cat.update!(cat_params)
      flash[:notice] = "Category successfully edited"
      redirect_to @cat
    else
      flash[:notice] = "Category could not be edited"
      render 'edit'
    end
  end
    
  def view_cats
    @cats = Cat.paginate(page: params[:page], per_page: 10)
    authorize! :read, @cats
  end
  
  def destroy
    @cat = Cat.find(params[:id])
    authorize! :destroy, @cat
    if @cat.destroy
      flash[:notice] = "Category successfully deleted"
    else
      flash[:notice] = "Category could not be deleted"
    end
    redirect_to cats_path
  end
  
  def show
    @cat = Cat.find(params[:id])
    authorize! :read, @cat
  end
  
  def search_by_category
    @cat = Cat.new
    authorize! :read, @cat
  end
  
  def show_search_by_category
    q = params[:cat][:id]
    @cat = Cat.where('id LIKE ?', "%#{q}%")
    books = Book.where(:cat_id => @cat)
    @books = books.paginate(page: params[:page], per_page: 10)
    authorize! :read, @books
    number_of_books_borrowed = Borrow.where(:user_id => current_user.id)
    @number_of_books_not_returned = number_of_books_borrowed.select{|borrow| borrow.returned == false }.size
  end
  
  
  
  private
  
  def cat_params
    params.require(:cat).permit(:id, :description)
  end
  
end
