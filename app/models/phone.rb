class Phone < ApplicationRecord
  validates :number, uniqueness: true
  validates :number,  presence: true
  validates :number, length: { in: 9..12 }
  belongs_to :user
end
