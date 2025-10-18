import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/widgets/wheather_service.dart';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({super.key});

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  WheatherService wheatherService = WheatherService();
  bool _useFahrenheit = false;

  final List<String> _cities = ['New York', 'London', 'Tokyo', 'Invalid City'];

  @override
  void initState() {
    super.initState();
    wheatherService.loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // City selection
          Row(
            children: [
              const Text('City: '),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  value: wheatherService.selectedCity,
                  isExpanded: true,
                  items: _cities.map((city) {
                    return DropdownMenuItem(value: city, child: Text(city));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        wheatherService.selectedCity = value;
                        wheatherService.loadWeather();
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => setState(() {
                  wheatherService.loadWeather();
                }),
                child: const Text('Refresh'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Temperature unit toggle
          Row(
            children: [
              const Text('Temperature Unit:'),
              const SizedBox(width: 10),
              Switch(
                value: _useFahrenheit,
                onChanged: (value) {
                  setState(() {
                    _useFahrenheit = value;
                  });
                },
              ),
              Text(_useFahrenheit ? 'Fahrenheit' : 'Celsius'),
            ],
          ),
          const SizedBox(height: 16),

          if (wheatherService.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (wheatherService.weatherData != null)
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          wheatherService.weatherData!.icon ?? '',
                          style: const TextStyle(fontSize: 48),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                wheatherService.weatherData!.city ?? '',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                wheatherService.weatherData!.description ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        _useFahrenheit
                            ? '${wheatherService.celsiusToFahrenheit(wheatherService.weatherData!.temperatureCelsius ?? 0).toStringAsFixed(1)}°F'
                            : '${wheatherService.weatherData!.temperatureCelsius?.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildWeatherDetail(
                          'Humidity',
                          '${wheatherService.weatherData!.humidity}%',
                          Icons.water_drop,
                        ),
                        _buildWeatherDetail(
                          'Wind Speed',
                          '${wheatherService.weatherData!.windSpeed} km/h',
                          Icons.air,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
           
          else if (wheatherService.error == null)
            Icon(Icons.error),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 32),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class WeatherData {
  final String? city;
  final double? temperatureCelsius;
  final String? description;
  final int? humidity;
  final double? windSpeed;
  final String? icon;

  WeatherData({
    this.city,
    this.temperatureCelsius,
    this.description,
    this.humidity,
    this.windSpeed,
    this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic>? json) {
    return WeatherData(
      city: json!['city'],
      temperatureCelsius: json['temperature'].toDouble(),
      description: json['description'],
      humidity: json['humidity'],
      windSpeed: json['windSpeed'].toDouble(),
      icon: json['icon'],
    );
  }
}
