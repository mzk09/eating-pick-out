class Restaurant < ApplicationRecord
  has_one_attached:image
  has_many :favorites,dependent: :destroy
  has_many :reviews,dependent: :destroy

  validates:name,presence:true
  validates:business_time,presence:true
  validates:price,presence:true
  validates:telephone_number,presence:true
  validates:address,presence:true
  validates:is_active, inclusion: [true, false]

  geocoded_by :address
  after_validation :geocode

  acts_as_mappable default_units: :kms,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
    end
    image.variant(resize_to_limit:[width,height]).processed
  end


  def favorited_by?(customer)
    favorites.where(customer_id:customer).exists?
    # favorites.exists?(customer_id:customer.id)
  end

end
