class WeatherController < ApplicationController
  def index
    render :index
  end

  def forecast
    response = HTTParty.get("http://localhost:5000/weather/#{params[:city]}")
    @forecast = JSON.parse(response.body)
    render json: @forecast
  rescue StandardError => e
    render json: { error: 'Weather service unavailable' }, status: :service_unavailable
  end
end
