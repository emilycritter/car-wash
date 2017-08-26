class Customer < ActiveRecord::Base
  has_many :transactions, dependent: :destroy
  validates :license, :vehicle_type, presence: true
  validates_uniqueness_of :license
  validates :vehicle_type, :inclusion=> { :in => ['car','truck'] }
end
