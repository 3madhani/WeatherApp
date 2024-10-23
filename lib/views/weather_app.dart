import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String cityName = 'city';

  Widget image = LottieBuilder.asset(
    'assets/lottie/data.json',
  );

  double temp = 0.0;

  double maxTemp = 0.0;

  double minTemp = 0.0;

  String condition = 'Condition';
  double feelsLike = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xff13182e),
          // drawer: const Drawer(),
          // appBar: AppBar(
          //   title: const Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: Text(
          //           'Weather App',
          //           overflow: TextOverflow.ellipsis,
          //           maxLines: 1,
          //           style: TextStyle(
          //             fontWeight: FontWeight.w900,
          //             color: Colors.orange,
          //             fontSize: 30,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                    onSubmitted: (value) async {
                      WeatherModel weatherModel =
                          await WeatherService(Dio()).getWeather(value);
                      setState(() {
                        cityName = weatherModel.cityName;
                        condition = weatherModel.condition;
                        temp = weatherModel.temp;
                        maxTemp = weatherModel.maxTemp;
                        minTemp = weatherModel.minTemp;
                        feelsLike = weatherModel.feelsLike;
                        image = setImage(condition);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'search',
                      labelStyle: const TextStyle(
                        fontSize: 24,
                      ),
                      hintText: 'Enter city name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          width: 3,
                        ),
                      ),
                      focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 17),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 10,
                      bottom: 8,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                        condition,
                        style: const TextStyle(
                            color: Color(0xffc0c1d6),
                            fontSize: 44,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: image,
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                overflow: TextOverflow.ellipsis,
                                cityName,
                                style: const TextStyle(
                                  color: Color(0xff918ea9),
                                  fontSize: 28,
                                ),
                              ),
                              subtitle: Text(
                                overflow: TextOverflow.ellipsis,
                                '$temp⁰',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 64,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  'feels like: $feelsLike',
                                  style: const TextStyle(
                                    color: Color(0xff918ea9),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: const Text(
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  'MaxTemp',
                                  style: TextStyle(
                                    color: Color(0xff918ea9),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    '$maxTemp⁰',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 34,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: const Text(
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  'MinTemp',
                                  style: TextStyle(
                                    color: Color(0xff918ea9),
                                    fontSize: 22,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    '$minTemp⁰',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 34,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget setImage(String condition) {
  Widget image;
  switch (condition) {
    case 'Clear':
      image = SvgPicture.asset(
        'assets/lottie/animated/day.svg',
        height: 700,
        width: 700,
      );
      break;
    case 'Clouds':
      image = SvgPicture.asset(
        'assets/lottie/animated/cloudy-day-1.svg',
        height: 700,
        width: 700,
      );
      break;
    case 'Rainy':
      image = SvgPicture.asset(
        'assets/lottie/animated/rainy-1.svg',
        height: 700,
        width: 700,
      );
      break;
    case 'Night':
      image = SvgPicture.asset(
        'assets/lottie/animated/night.svg',
        height: 700,
        width: 700,
      );
      break;
    default:
      image = SvgPicture.asset(
        'assets/lottie/animated/weather_sagittarius.svg',
        height: 700,
        width: 700,
      );
  }
  return image;
}
