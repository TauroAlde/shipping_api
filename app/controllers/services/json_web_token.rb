class Services::JsonWebToken
  def self.encode(user, exp = 24.hours.from_now.to_i)
    payload = Services::JwtPayload.new(user, exp: exp)
    token = JWT.encode payload.data, ENV["PRIVATE_SECRET_KEY"], 'HS256'
  end

  def self.decode(token)
    leeway = ENV['EXP_LEEWAY'].to_i
    decoded = JWT.decode token, ENV["PRIVATE_SECRET_KEY"], true, { algorithm: 'HS256', exp_leeway: leeway }
    user = find_user(decoded[0]["sub"])
  end

  private

  def self.find_user(sub)
    user = User.find_by(id: sub)
  end
end
