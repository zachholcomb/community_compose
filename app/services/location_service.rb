class LocationService
  class << self
    def zip_codes(zip_code)
      resp = Faraday.get("https://cc-location-api.herokuapp.com/#{zip_code}")
      get_json(resp)
    end

    private

    def get_json(resp)
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end
