class Movie < ActiveRecord::Base

  RATINGS = %w{ g pg pg-13 r nc-17 }
  CURRENCIES = {}

  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :reviews

  def self.conversion(exchange_currency, amount)
    # NOTE: Some exchange_currency do NOT convert to ::ISO4217::Currency, e.g. ESP for Spain
    if exchange_currency != 'USD' && currency = ::ISO4217::Currency.from_code(exchange_currency)
      CURRENCIES[exchange_currency] ||= currency
      currency ? currency.exchange_rate * amount.to_i : amount
    else
      amount
    end
  end

end
