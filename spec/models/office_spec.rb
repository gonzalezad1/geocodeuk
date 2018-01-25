require 'rails_helper'

RSpec.describe Office, type: :model do
  describe '#uri_postcode' do
    it 'reponse well if lat and lng present' do
      expect(Office.uri_postcode(53.4764062,-2.2333863)).to eq  'M1 3GY'
    end
  end

  describe '#search' do
    it 'return result if office inside the radius' do
      office = Office.create(address: "42-48 The Cut Lambeth, London SE1 8LP Royaume-Uni" ,lat:  51.5034039 ,lng:  -0.106829 ,postcode: "SE1 8LP", name: "Office London")
      expect(Office.search("SE18LP",20)).toOffice include(office)
    end
  end
end