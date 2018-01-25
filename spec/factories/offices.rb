require 'rails_helper'

FactoryGirl.define do
factory :office do |f|
  f.address "3 Cobourg St Manchester M1 Royaume-Uni"
  f.lat  53.4764062
  f.lng  -2.2333863
  f.postcode "M1 3G"
  f.name "Office Sud"
end

factory :invalid_office do |f|
  f.address nil
  f.lat  53.4764062
  f.lng  -2.2333863
  f.postcode "M1 3G"
  f.name "Office Sud"
end
end
