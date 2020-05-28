class FlatService
  class << self
    def get_user(current_user)
      resp = conn(current_user).get('/v2/me')
      # require "pry"; binding.pry
      get_json(resp)
    end

    def get_scores(current_user)
      resp = conn(current_user).get('/v2/users/me/scores')
      get_json(resp)
    end

    private

    def conn(current_user)
      Faraday.new('https://api.flat.io') do |f|
        f.headers[:Authorization] = "Bearer #{current_user.flat_key}"
      end
    end

    def get_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
