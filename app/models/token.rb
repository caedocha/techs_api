require 'jwt'
class Token
  def self.encode(payload)
    JWT.encode(
      payload.merge({exp: EXPIRATION_DATE}),
      SECRET,
      ALGORITHM
    )
  end

  def self.decode(payload)
    HashWithIndifferentAccess.new(JWT.decode(payload, SECRET)[0])
  end

  private

  ALGORITHM = "HS256"
  EXPIRATION_DATE = (Time.now + 1.day).to_i
  SECRET = Rails.application.secrets.secret_key_base

end
