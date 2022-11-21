class Restaurant < ApplicationRecord
  has_one_attached:image
  has_many :favorites,dependent: :destroy

  validates:name,presence:true
  validates:business_time,presence:true
  validates:price,presence:true
  validates:telephone_number,presence:true
  validates:address,presence:true
  validates:is_active, inclusion: [true, false]

  def get_image(*size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
    end
    if !size.empty?
      image.variant(resize: size)
    else
      image
    end
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id:customer.id)
  end

end
