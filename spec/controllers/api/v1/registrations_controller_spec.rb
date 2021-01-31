require 'rails_helper'

describe Api::V1::RegistrationsController , :type => :request do
  before do
    @params = { user: { email: 'test@test.com', password: 'password' } }
  end

  context "POST Registrations" do
    context "failure" do
      it "without app api_key" do
        post api_v1_registrations_url(@params)
        expect(response).to have_http_status(:unauthorized)
      end

      it "with existing user" do
        User.create(@params[:user])
        post api_v1_registrations_url(@params), headers: { "X-API-KEY": Rails.application.credentials.api[:app_key] }
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['success']).to be_falsey
        expect(body['data']).to be_nil
        expect(body['errors'].length).to eq 1
      end
    end

    context "success" do
      it "with app api_key" do
        post api_v1_registrations_url(@params), headers: { "X-API-KEY": Rails.application.credentials.api[:app_key] }
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['success']).to be_truthy
        expect(body['data']).to_not be_nil
        expect(body['data']['email']).to eq @params[:user][:email]
      end
    end
  end

end