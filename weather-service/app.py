from flask import Flask, jsonify
from flask_cors import CORS
import random  # Just for demo purposes

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

@app.route('/weather/<city>')
def get_weather(city):
    # In a real app, you'd call a weather API here
    # This is just mock data for demonstration
    weather_data = {
        'city': city,
        'temperature': random.randint(0, 30),
        'conditions': random.choice(['Sunny', 'Cloudy', 'Rainy'])
    }
    return jsonify(weather_data)

if __name__ == '__main__':
    app.run(port=5000)
