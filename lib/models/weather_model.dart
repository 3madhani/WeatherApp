
class WeatherModel {
  final String cityName;
  final String image;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final double feelsLike;

  WeatherModel({
    required this.cityName,
    required this.image,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.feelsLike,
  });

  factory WeatherModel.fromJson(json) {
    return WeatherModel(
        image: json['weather'][0]['icon'],
        cityName: json['name'],
        temp: json['main']['temp'],
        maxTemp: json['main']['temp_max'],
        minTemp: json['main']['temp_min'],
        condition: json['weather'][0]['main'],
        feelsLike: json['main']['feels_like']
        );
  }
}
