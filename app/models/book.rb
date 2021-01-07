class Book < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy_async
  validates :title, presence: true, length:{maximum: 127}
end
