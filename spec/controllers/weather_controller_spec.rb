require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'GET #index' do
    # The 'it' block was missing
    it 'returns a successful response' do  # Add this line
      get :index
      expect(response).to be_successful
    end  # And this line
  end

  describe 'GET #forecast' do
    let(:city) { 'London' }
    let(:weather_data) do
      {
        'city' => city,
        'temperature' => 20,
        'conditions' => 'Sunny'
      }
    end

    context 'when Python service is available' do
      before do
        stub_request(:get, "http://localhost:5000/weather/#{city}")
          .to_return(status: 200, body: weather_data.to_json)
      end

      it 'returns weather data for the city' do
        get :forecast, params: { city: city }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(weather_data)
      end
    end

    context 'when Python service is unavailable' do
      before do
        stub_request(:get, "http://localhost:5000/weather/#{city}")
          .to_return(status: 500)
      end

      it 'returns a service unavailable error' do
        get :forecast, params: { city: city }
        expect(response).to have_http_status(:service_unavailable)
        expect(JSON.parse(response.body)).to include('error')
      end
    end
  end
end
