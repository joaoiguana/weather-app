require 'rails_helper'

RSpec.describe 'Weather Interface', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'allows users to search for weather by city' do
    weather_data = {
      'city' => 'London',
      'temperature' => 20,
      'conditions' => 'Sunny'
    }

    # Mock the API call
    stub_request(:get, 'http://localhost:5000/weather/London')
      .to_return(status: 200, body: weather_data.to_json)

    visit root_path
    fill_in 'city', with: 'London'
    click_button 'Get Forecast'

    # Wait for AJAX request to complete
    expect(page).to have_content('Temperature: 20°C')
    expect(page).to have_content('Conditions: Sunny')
  end
end
