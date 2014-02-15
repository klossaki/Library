class Book < ActiveRecord::Base
  belongs_to :cat
  belongs_to :author
  validates :title, presence: true, length: { maximum: 40 }, uniqueness: true
  validates :isbn, presence: true, length: { maximum: 10 }, uniqueness: true
  validates :author_id, :cat_id, :copies, presence: true
  validates :copies, presence: true, numericality: { only_integer: true }
  validates :rank, presence: true, numericality: { only_integer: true }
  has_many :borrows
  has_many :users, through: :borrows
  has_many :borrows, :dependent => :destroy
  has_many :userbookranks
  has_many :users, through: :userbookranks
  has_many :userbookranks, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :comments, through: :comments
end
