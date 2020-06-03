class Location
  def self.distances(zip_code)
    zip_codes = LocationService.zip_codes(zip_code)
    zip_codes[:zip_codes].reduce({}) do |list, zip|
      list[zip[:zip_code]] = zip[:distance]
      list
    end
  end
end
