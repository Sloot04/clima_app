import 'package:api_clima/class/city_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:api_clima/class/city_weather.dart';

Future<CityWeather> getWeather(String city) async {
  final url = Uri.parse(
      "http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=252a7ec697ac784e8a0e7a6bc28d2aaf");
  try {
    final get = await http.get(url);
    final city = cityWeatherFromJson(get.body);
    return city;
  } catch (e) {
    return CityWeather(name: 'Ciudad no encontrada');
  }
}

Future<CityForecast> getForecast(double lon, double lat) async {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly,alerts&units=metric&appid=252a7ec697ac784e8a0e7a6bc28d2aaf");
  /* final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=current,minutely,hourly,alerts&appid=252a7ec697ac784e8a0e7a6bc28d2aaf"); */

  try {
    final get = await http.get(url);
    final cityForecast = cityForecastFromJson(get.body);

    return cityForecast;
  } catch (e) {
    return CityForecast(timezone: 'Pronostico no encontrado');
  }
}
