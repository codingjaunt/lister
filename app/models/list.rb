# List Record
class List < ApplicationRecord
  has_one :user

  validates :name, presence: true,
                   allow_blank: false,
                   length: { maximum: 255 }
end
