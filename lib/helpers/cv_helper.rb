module CVHelper
  def stars(amount, max: 3)
    ('★' * amount.to_i) + ('☆' * (max - amount.to_i))
  end
end
