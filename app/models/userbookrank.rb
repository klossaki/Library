class Userbookrank < ActiveRecord::Base
  validates :user_id, :book_id, :rank, presence: true
  
  validates_uniqueness_of :user_id, :scope => :book_id
  
  belongs_to :user
  belongs_to :book
end
