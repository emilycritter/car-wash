class Customer < ActiveRecord::Base
  has_many :transactions, dependent: :destroy

  validates :license, :vehicle_type, presence: true
  validates :license, length: { minimum: 4, maximum: 8 }
  validates_format_of :license, with: /[A-Za-z0-9]+/
  validates_uniqueness_of :license
  validates :vehicle_type, :inclusion => { :in => ['car','truck'] }
end
