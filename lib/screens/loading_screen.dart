import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'd58e29ee6bc407ae95eb59265d3b5532';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();

    var weatherData = await weatherModel.getLocationWeather();

    print(weatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        color: Colors.blue,
        size: 100.0,
      )),
    );
  }
}
