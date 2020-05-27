class FlatService
  class << self
    def get_user(current_user)
      resp = conn.get('/v2/me')
      get_json(resp)
    end

    def get_scores(current_user)
      resp = conn.get('/v2/users/me/scores')
      get_json(resp)
    end

    private

    def conn
      Faraday.new('https://api.flat.io') do |f|
        f.headers[:Authorization] = "Bearer #{ENV['FLAT_KEY']}"
      end
    end

    def get_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
