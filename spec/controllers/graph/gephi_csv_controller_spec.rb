require 'rails_helper'

describe Graph::GephiCsvController do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
