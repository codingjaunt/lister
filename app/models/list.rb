# List Record
class List < ApplicationRecord
  belongs_to :user

  validates :name, presence: true,
                   allow_blank: false,
                   length: { maximum: 255 },
                   uniqueness: true
end
