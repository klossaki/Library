class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :book
  
  validates :user_id, :book_id, :comment, :date_of_comment, presence: true


end
