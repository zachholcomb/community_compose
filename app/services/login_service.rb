class LoginService
  class << self
    def log_user_in(code)
      response = response(data(code))
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def data(code)
      {
        grant_type: 'authorization_code',
        code: code,
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET'],
        redirect_uri: ENV['CALLBACK']
      }
    end

    def response(data)
      Faraday.post('https://api.flat.io/oauth/access_token') do |resp|
        resp.headers['content-type'] = 'application/x-www-form-urlencoded'
        resp.body = URI.encode_www_form(data)
      end
    end
  end
end
