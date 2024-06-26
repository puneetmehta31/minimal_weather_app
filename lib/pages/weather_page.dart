import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_application/models/weather_models.dart';
import 'package:weather_application/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
 //api key 
 final _weatherService = WeatherService('627bf7b1b4a70491ff6fd9d9c9294b3');
Weather ?_weather;


//fetch weather 
_fetchWeather() async{
  //get the current city 

String cityName = await _weatherService.getCurrentCity();

  //get weather for city 
  try {
    final weather =await _weatherService.getWeather(cityName);
    setState(() {
      _weather =weather;
    });
  }


//any errors 
catch(e){
  print(e);
}


}

// weather animations 

String getWeatherAnimation(String?mainCondition){
  if (mainCondition == null) return 'assets/sunny.json';
  switch(mainCondition.toLowerCase()){
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
    return 'assets/cloudy.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
       return 'assets/rainy.json';
    case 'thunderstorm':
    return 'assets/storm.json';
    case  'clear':
     return 'assets/sunny.json';
    default :
    return 'assets/sunny.json';

  }
}


//init state 
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetch the waether on startup

_fetchWeather();
  }
  
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 182, 182),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
          //cityname
          Text(_weather?.cityName??"loading city.."),
        
         //animation 
         Lottie.asset(getWeatherAnimation(_weather?.mainCondition??"")),

          //temperature
          Text('${_weather?.temperature.round()}°C'),

          //weather condition
          Text(_weather?.mainCondition??"")
        ],),
      ),
    );
  }
}