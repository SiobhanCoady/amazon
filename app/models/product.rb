class Product < ApplicationRecord
  validates(:title, { presence: true,
                      uniqueness: { case_sensitive: false },
                      exclusion: { in: %w(Apple Microsoft Sony),
                                   message: "%{value} is reserved." } })
  validates(:description, { presence: true, length: { minimum: 10 } })
  validates(:price, { presence: true,
                      numericality: { greater_than: 0 } })
  # validates(:sale_price, { numericality: { less_than_or_equal_to: self.price } })

  validate :price_is_valid_decimal_precision
  validate :sale_price_is_not_greater_than_price

  after_initialize :set_defaults
  before_save :capitalize_title

  def self.search(string)
    where(['title ILIKE ? OR description ILIKE ?', "%#{string}%", "%#{string}%"]).order(['description ILIKE ?', "%#{string}%"], ['title ILIKE ?', "%#{string}%"])
  end

  private

  def price_is_valid_decimal_precision
    # Make sure that the rounded value is the same as the non-rounded
    if price.to_f != price.to_f.round(2)
      errors.add(:price, "The price of the product is invalid. There should only be two digits at most after the decimal point.")
    end
  end

  def sale_price_is_not_greater_than_price
    if sale_price > price
      errors.add(:sale_price, "The sale price must not be greater than the price.")
    end
  end

  def set_defaults
    self.price ||= 1
    self.sale_price ||= self.price
  end

  def capitalize_title
    # self.title = title.capitalize! if title.present?
    self.title = title.titleize if title.present?
  end

end
