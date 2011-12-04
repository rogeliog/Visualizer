# Geocoder::Configuration.lookup = :yahoo

module Geoutils

  class Utils

    def getcoords(address)
      lookup(address) || save_state(address)
    end

    def lookup(address)
      state = State.where(:address => address).first
      state && state.coords
    end

    def save_state(address)
      lng, lat = Geocoder.coordinates("#{address}, Mexico")
      state = State.create(:address => address, :coords => [lat, lng])
      state.coords
    end

  end

end
