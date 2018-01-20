require 'net/http'
# require 'httparty'
# require 'rest-client'
require 'json'

class Office < ApplicationRecord
  include Geokit::Geocoders
  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  scope :find_all_office, -> (lat,lng,rad) { find(:all, :origin =>[lat,lng], :within=> rad).sort_by{|s| s.distance_to(origin)} }

  def self.uri_postcode lat ,long

    url = "http://api.postcodes.io/postcodes?lon=#{long}&lat=#{lat}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    postcode= JSON.parse(response)
    return postcode["result"][0]["postcode"] if postcode && postcode["result"]
  end

  def self.uri_lat_long address
    arr= []
    loc=Geokit::Geocoders::MultiGeocoder.geocode (address)
    if loc.success
      arr << loc.lat << loc.lng << loc.full_address
    else
      # flash.alert = "Could not Geocode address"
      # errors.add(:address, "Could not Geocode address")
    end
    return arr
  end

  def self.search(postcode,radius)

    if postcode && radius
      url = "http://api.postcodes.io/postcodes/#{postcode}"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      postcode_full= JSON.parse(response)
      Office.within(radius,:origin =>[postcode_full["result"]["latitude"],postcode_full["result"]["longitude"]]).sort_by{|s| s.distance_to([postcode_full["result"]["latitude"],postcode_full["result"]["longitude"]])}
      # find(:all, , :within=>radius).sort_by{|s| s.distance_to([postcode_full["result"]["latitude"],postcode_full["result"]["longitude"]])}
    else
      self.all
    end
  end


end
