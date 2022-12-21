class Genre < ApplicationRecord
  validates:name,presence:true

  has_many :restaurants,dependent: :destroy

  scope :only_active, -> { where(is_active: true) }
end
