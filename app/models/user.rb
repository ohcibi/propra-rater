module SecureToken
  BASE58_ALPHABET = ('0'..'9').to_a  + ('A'..'Z').to_a + ('a'..'z').to_a - ['0', 'O', 'I', 'l']

  def self.base58(n = 16)
    SecureRandom.random_bytes(n).unpack("C*").map do |byte|
      idx = byte % 64
      idx = SecureRandom.random_number(58) if idx >= 58
      BASE58_ALPHABET[idx]
    end.join
  end
end

class User < ActiveRecord::Base
  before_create do
    self.token = self.class.generate_unique_secure_token unless self.token?
  end

  def regenerate_token!
    update! token: self.class.generate_unique_secure_token
    update_token_expiration!
  end

  def update_token_expiration!
    update! token_expires_at: (DateTime.now + Rational(1, 48))
  end

  def self.generate_unique_secure_token
    SecureToken.base58 48
  end
end
