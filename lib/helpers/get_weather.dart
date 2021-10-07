import 'package:http/http.dart' as http;
import 'package:api_clima/class/city_weather.dart';

Future<CityWeather> getWeather(String city) async {
  final url = Uri.parse(
      "http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=252a7ec697ac784e8a0e7a6bc28d2aaf");
  final get = await http.get(url);
  if (get.statusCode == 200) {
    final city = cityWeatherFromJson(get.body);
    return city;
  } else {
    throw Exception('Failed to load');
  }
}
