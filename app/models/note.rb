class Note < ApplicationRecord
  belongs_to :book
  validates :title, presence: true, length:{maximum: 127}
end
