import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_get_weather(client):
    # Test weather endpoint
    response = client.get('/weather/London')
    data = response.get_json()

    assert response.status_code == 200
    assert 'city' in data
    assert data['city'] == 'London'
    assert 'temperature' in data
    assert isinstance(data['temperature'], int)
    assert 'conditions' in data
    assert data['conditions'] in ['Sunny', 'Cloudy', 'Rainy']

def test_invalid_city(client):
    # Test with empty city name
    response = client.get('/weather/')
    assert response.status_code == 404
