class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :restaurant

    validates:comment,presence:true

  #↓評価機能を付けるまではコメントアウト
  #validates :rate, numericality: {
  # less_than_or_equal_to: 5,
   # greater_than_or_equal_to: 1}, presence: true



end
