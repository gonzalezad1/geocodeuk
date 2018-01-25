require 'net/http'
require 'json'

class Office < ApplicationRecord
  include Geokit::Geocoders
  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  validates :name, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :address, presence: true
  validates :postcode, presence: true

  class << self
    def uri_postcode lat ,long
      #use of postcode.io to take postcode from latitude and longitude
      json_output = Office.request_api("http://api.postcodes.io/postcodes?lon=#{long}&lat=#{lat}")
      @postcode = Office.transform_json(json_output)
    end

    def uri_lat_long address
      #use of Geocoder to find latitude and longitude from an address
      @location = Geokit::Geocoders::MultiGeocoder.geocode (address)
      if @location.success
        @location
      end
    end

    def search postcode,radius
      if postcode && radius
        trans_poscode = postcode.gsub(/\s+/, "")
        postcode_full=Office.request_api("http://api.postcodes.io/postcodes/#{trans_poscode}")
        @home = [postcode_full[:result][:latitude],postcode_full[:result][:longitude]]
        Office.within(radius,:origin => @home).sort_by{|s| s.distance_to(@home)}
      else
        self.all
      end
    end

    def transform_json(json_input)
      json_input[:result][0][:postcode]
    end

    def request_api(url_input)
      url = url_input
      uri = URI(url)
      response = Net::HTTP.get(uri)
      JSON.parse(response).with_indifferent_access
    end
  end
end
