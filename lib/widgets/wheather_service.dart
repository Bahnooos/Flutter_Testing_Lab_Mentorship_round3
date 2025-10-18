// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'weather_display.dart';

class WheatherService {
  WeatherData? weatherData;
  bool isLoading = false;
  String? error;
  String selectedCity = 'New York';
  WheatherService({this.weatherData});

  double celsiusToFahrenheit(double celsius) {
    return (celsius * 1.8) + 32;
  }

  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) / 1.8;
  }

  // Simulate API call that sometimes returns null or malformed data
  Future<Map<String, dynamic>?> _fetchWeatherData(String city) async {
    await Future.delayed(const Duration(seconds: 2));

    if (city == 'Invalid City') {
      return null;
    }

    if (DateTime.now().millisecond % 4 == 0) {
      return {'city': city, 'temperature': 22.5};
    }

    return {
      'city': city,
      'temperature': city == 'London' ? 15.0 : (city == 'Tokyo' ? 25.0 : 22.5),
      'description': city == 'London'
          ? 'Rainy'
          : (city == 'Tokyo' ? 'Cloudy' : 'Sunny'),
      'humidity': city == 'London' ? 85 : (city == 'Tokyo' ? 70 : 65),
      'windSpeed': city == 'London' ? 8.5 : (city == 'Tokyo' ? 5.2 : 12.3),
      'icon': city == 'London' ? '🌧️' : (city == 'Tokyo' ? '☁️' : '☀️'),
    };
  }

  Future<void> loadWeather() async {
    isLoading = true;
    Future.delayed(Duration(milliseconds: 2500));
    final data = await _fetchWeatherData(selectedCity);
    weatherData = WeatherData.fromJson(data);
    isLoading = false;
    error = null;
  }
}
