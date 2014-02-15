class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :borrows
  has_many :books, through: :borrows
  has_many :borrows, :dependent => :destroy
  has_many :userbookranks
  has_many :users, through: :userbookranks
  has_many :userbookranks, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :books, through: :comments
end
