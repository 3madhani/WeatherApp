import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {

  final Dio dio ;

  WeatherService(this.dio);

  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = '65fd4fb31697e12eed5f0af06e2407b5';

  Future<WeatherModel> getWeather(String cityName) async {
    Response response = await
        dio.get('$baseUrl?q=$cityName&appid=$apiKey&units=metric');
        Map<String, dynamic> jsonData = response.data;
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
    return weatherModel;
  }
}