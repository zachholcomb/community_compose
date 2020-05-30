class FlatService
  class << self
    attr_accessor :flat_key

    def get_user
      get_json(conn.get('/v2/me'))
    end

    def get_scores(user_id)
      response = conn.get("/v2/users/#{user_id}/scores")
      response.body.empty? ? [] : get_json(response)
    end

    def get_score(score_id)
      get_json(conn.get("/v2/scores/#{score_id}"))
    end

    def delete_score(score_id)
      conn.delete("/v2/scores/#{score_id}")
    end

    def add_collaborator(score_id, user_id)
      conn.post("/v2/scores/#{score_id}/collaborators") do |request|
        request.body = "{ 'user': #{user_id}, 'aclWrite': true }"
      end
    end

    def create_score(title)
      file = File.read('./xml_files/template.musicxml')
      enc = Base64.encode64(file)
      conn.post('/v2/scores') do |request|
        request.body = "{ 'title': #{title},
                          'data': #{enc},
                          'dataEncoding': 'base64'
                        }"
      end
    end

    private

    def conn
      Faraday.new('https://api.flat.io') do |f|
        f.headers[:Authorization] = "Bearer #{@flat_key}"
      end
    end

    def get_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
