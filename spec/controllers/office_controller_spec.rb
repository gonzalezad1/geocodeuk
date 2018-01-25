require 'rails_helper'

RSpec.describe OfficesController do

  describe "GET #index" do
    it "populates an array of offices" do
      office = Office.create(address: "3 Cobourg St Manchester M1 Royaume-Uni" ,lat:  53.4764062 ,lng:  -2.2333863 ,postcode: "M1 3G", name: "Office Sud")
      get :index
      assigns(:offices).should eq(Office.all)
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested contact to @office" do
      office = Office.create(address: "3 Cobourg St Manchester M1 Royaume-Uni" ,lat:  53.4764062 ,lng:  -2.2333863 ,postcode: "M1 3G", name: "Office Sud")
      get :show, params: { id: office.id }
      assigns(:office).should eq(office)
    end
  end
end

