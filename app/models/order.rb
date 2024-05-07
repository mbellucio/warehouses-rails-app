class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  has_many :order_items
  has_many :product_models, through: :order_items
  enum status: {pending: 0, delivered: 5, canceled: 9}

  validates :code, :arrival_date, presence: true
  validate :arrival_date_is_future

  before_validation :generate_code

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def arrival_date_is_future
    if self.arrival_date.present? && self.arrival_date <= Date.today
      self.errors.add(:arrival_date, " deve ser futura.")
    end
  end
end
