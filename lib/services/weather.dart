import '../services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  static const apiKey = 'd58e29ee6bc407ae95eb59265d3b5532';
  static const weatherMapURL =
      "https://api.openweathermap.org/data/2.5/weather";

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper helper = NetworkHelper("$weatherMapURL?"
        "q=$cityName"
        "&appid=$apiKey"
        "&units=metric");

    var weatherData = await helper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentPosition();

    NetworkHelper helper = NetworkHelper("$weatherMapURL?"
        "lat=${location.latitude}"
        "&lon=${location.longitude}"
        "&appid=$apiKey&units=metric");

    var weatherData = await helper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
