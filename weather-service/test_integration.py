import requests
import pytest

def test_rails_python_integration():
    """
    Integration test to verify Rails and Python services work together.
    Note: Both services must be running for this test.
    """
    try:
        # First, check if Python service is responding
        python_response = requests.get('http://localhost:5000/weather/London')
        assert python_response.status_code == 200

        # Then check if Rails app can get the data
        rails_response = requests.get('http://localhost:3000/forecast/London')
        assert rails_response.status_code == 200

        # Verify data structure
        data = rails_response.json()
        assert 'city' in data
        assert 'temperature' in data
        assert 'conditions' in data
    except requests.ConnectionError:
        pytest.skip("One or both services are not running")
