class User < ApplicationRecord

  has_secure_password

  validates :name, uniqueness: true
  validates :name, presence: true

  def self.from_token_request(request)
    name = request.params["auth"] && request.params["auth"]["name"]
    self.find_by(name: name)
  end

  before_create do |user|
    #user.api_key = user.generate_api_key
  end

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end

end
