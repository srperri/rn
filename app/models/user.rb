class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :books, dependent: :destroy_async
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def global_book
    books.find_by! is_global: true
  end
      
  private 
    after_create do
      books.create!(title: '__global__', is_global: true)
    end
end
