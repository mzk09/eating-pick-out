class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :restaurant

  #validates:comment,presence:true
  validates:is_active, inclusion: [true, false]

  scope :is_active, -> { where(is_active: true) }

  #↓評価機能を付けるまではコメントアウト
  validates :rate, numericality: {
   less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true



end
