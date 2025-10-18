import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';
import 'package:flutter_testing_lab/widgets/wheather_service.dart';

void main() {
  late WeatherData weatherData;
  late WheatherService wheatherService;

  setUp(() {
    weatherData = WeatherData(
      city: 'minya',
      description: 'nothing',
      humidity: 1,
      windSpeed: 20,
      icon: 'sdzc',
      temperatureCelsius: 22,
    );
    wheatherService = WheatherService(weatherData: weatherData);
  });
  group(' Wheather Service -', () {
    test('when call loadWeather then return weatherData', () async {
      await wheatherService.loadWeather();
      expect(wheatherService.weatherData, isA<WeatherData>());
    });

    test('when call loadWeather then return initial loading is true', () {
      wheatherService.loadWeather();
      final result = wheatherService.isLoading;
      expect(result, true);
    });
  });
}
