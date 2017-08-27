class Customer < ActiveRecord::Base
  has_many :transactions, dependent: :destroy

  validates :license, :vehicle_type, presence: true
  validates :license, length: { minimum: 4, maximum: 8 }
  validates_format_of :license, with: /\A[a-zA-Z0-9]{4,8}\Z/
  validates_uniqueness_of :license
  validates :vehicle_type, :inclusion => { :in => ['car','truck'] }

  before_create :format_license

  def format_license
    self.license = self.license.upcase
  end

end
