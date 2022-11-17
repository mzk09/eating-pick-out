class Restaurant < ApplicationRecord
  has_one_attached:image

  validates:name,presence:true
  validates:business_time,presence:true
  validates:price,presence:true
  validates:telephone_number,presence:true
  validates:address,presence:true
  validates:is_active, inclusion: [true, false]

end
