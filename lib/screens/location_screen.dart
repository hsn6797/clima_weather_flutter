import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String cityName;
  String dateToday;
  int weatherId;
  int mainTemp;
  String weatherCondition;
  String weatherImage;

  void resetVariables() {
    cityName = "Unavailable";
//    dateToday = "----";
    weatherId = 300;
    mainTemp = 0;
    weatherCondition = "Unavailable";
    weatherImage = '🤷‍';
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      dateToday = DateFormat("E, MMM d, y").format(DateTime.now());

      if (weatherData == null) {
        resetVariables();
        return;
      }

      cityName = weatherData["name"];
      weatherId = weatherData["weather"][0]["id"];
      weatherImage = weatherModel.getWeatherIcon(weatherId);
      print(weatherImage);
      weatherCondition = weatherData["weather"][0]["main"];

      var temp = weatherData["main"]["temp"];
      mainTemp = temp.round();
    });
  }

  @override
  void initState() {
    super.initState();
//    print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () async {
                          var results = await weatherModel.getLocationWeather();
                          updateUI(results);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () async {
                          var typedValue = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                          if (typedValue != null) {
                            var results =
                                await weatherModel.getCityWeather(typedValue);
                            updateUI(results);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                  flex: 6,
                  child: Column(
                    children: <Widget>[
                      Text(
                        cityName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.0,
                          letterSpacing: 5.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        dateToday,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30.0),
                        child: Text(
                          "$mainTemp°",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 110.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        weatherImage,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60.0,
                          letterSpacing: 8.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        weatherCondition,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          letterSpacing: 8.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
