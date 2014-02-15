class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
  end
  
  def index_by_book
    comments = Comment.where(:book_id => params[:book_id])
    total_number_of_comments = comments.count
    @comments = comments.paginate(page: params[:page], per_page: 5, :total_entries => total_number_of_comments)
    @book = Book.find(params[:book_id])
  end
  
  def create
    @comment = Comment.new(comment_params)
    authorize! :read, @comment
    if @comment.save
      flash[:notice] = "Comment successfully saved"
    else
      flash[:notice] = "Comment could not be saved"
    end
    redirect_to controller: :books, action: :view_books
  end

  
  private

  def comment_params
    params.require(:comment).permit(:book_id, :user_id, :date_of_comment, :comment)
  end

end
