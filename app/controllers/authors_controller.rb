class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end
  
  def new
  end
  
  def edit
    @author = Author.find(params[:id])
  end
  
  def create
    @author = Author.new(author_params)
    @author.save
    redirect_to action: :index
  end
  
  def update
    @author = Author.find(params[:id])
    if @author.update!(author_params)
      redirect_to @author
    else
      render 'edit'
    end
  end
    
def show
    @author = Author.find(params[:id])
end
  
  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    redirect_to authors_path
  end
  
  private
  
  def author_params
    params.require(:author).permit(:name)
  end
  
end
