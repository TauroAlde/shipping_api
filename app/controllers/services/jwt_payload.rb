class Services::JwtPayload
  attr_reader :data

  def initialize(user, exp:)
    @data = {
      sub: user.id,
      exp: exp
    }
  end
end
