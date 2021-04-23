import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'package:clima/utilities/reusable_card.dart';

class LocationScreen extends StatefulWidget {
  /// step 3. constructor invoked in loading screen
  LocationScreen({@required this.locationWeather});

  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temperature;
  String cityName;
  String country;

  var windDir;
  var windspeed;
  int humidity;
  double feelsLike;

  String weatherMessage;
  String weatherIcon;
  WeatherModel weatherModel = new WeatherModel();

  @override
  void initState() {
    super.initState();

    /// a stateful widget contains states
    /// the properties of the parent stateful widget can be accessed from the state definition
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    /// if we want the widget to update when this function is called,
    /// we need to invoke the setState function
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        return;
      }
      temperature = weatherData['main']['temp'];
      feelsLike = weatherData['main']['feels_like'];
      country = weatherData['sys']['country'];
      cityName = weatherData['name'];
      humidity = weatherData['main']['humidity'];

      //wind stuff
      windspeed = weatherData['wind']['speed'];
      print(windspeed);
      windDir = weatherData['wind']['deg'];
      var condition = weatherData['weather'][0]['id'];

      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature.toInt()) +
          ' in $cityName, $country';
    });
    // print(temperature);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ReusableCard(
                  colour: Colors.black,
                  cardChild: Column(
                    // crossAxisAlignment: CrossAxisAlignment.,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${temperature.toInt()}°',
                            style: kTempTextStyle,
                          ),
                          Text(
                            weatherIcon,
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        'Feels like: ${feelsLike.toInt()}°',
                        style: kMessageTextStyle,
                      ),
                      Text(
                        'Wind: ${(windspeed * 3.6).round()} km/h',
                        style: kMessageTextStyle,
                      ),
                      Text(
                        'Humidity: $humidity%',
                        style: kMessageTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              ReusableCard(
                colour: Colors.black,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      weatherMessage,
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
