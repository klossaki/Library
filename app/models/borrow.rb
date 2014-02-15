class Borrow < ActiveRecord::Base
  validates :user_id, :book_id, :date_of_borrow, presence: true
  
  belongs_to :user
  belongs_to :book
end
