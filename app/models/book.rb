class Book < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy_async
  validates :title, 
    presence: true,
    length:{maximum: 127}, 
    uniqueness:{ scope: :user_id, case_sensitive: false, message: "title already exists!" }

  def global?
    is_global
  end

end
