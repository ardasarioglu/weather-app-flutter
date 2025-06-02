
import 'package:flutter/material.dart';
import 'package:weather_app/models/daily_weather.dart';

class Daily extends StatefulWidget {
  final List<DailyWeather>? dailyWeathers;
  const Daily({super.key, this.dailyWeathers});

  @override
  State<Daily> createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  String getWeatherImagePath(int code) {
    if (code == 0 || code == 1) {
      return 'assets/images/clear.png';
    } else if (code == 2 || code == 3) {
      return 'assets/images/cloudy.png';
    } else if (code == 45 || code == 48) {
      return 'assets/images/fog.png';
    } else if ([51, 53, 55, 56, 57].contains(code)) {
      return 'assets/images/drizzle.png';
    } else if ([61, 63, 65, 66, 67].contains(code)) {
      return 'assets/images/rain.png';
    } else if ([71, 73, 75, 77].contains(code)) {
      return 'assets/images/snow.png';
    } else if ([80, 81, 82].contains(code)) {
      return 'assets/images/rainshower.png';
    } else if ([85, 86].contains(code)) {
      return 'assets/images/snowshower.png';
    } else if ([95, 96, 99].contains(code)) {
      return 'assets/images/thunderstorm.png';
    } else {
      return "error";
    }
  }

  String getWeatherDescription(int code) {
    if (code == 0 || code == 1)
      return "Clear";
    else if (code == 2 || code == 3)
      return "Cloudy";
    else if (code == 45 || code == 48)
      return "Fog";
    else if ([51, 53, 55, 56, 57].contains(code))
      return "Drizzle";
    else if ([61, 63, 65, 66, 67].contains(code))
      return "Rain";
    else if ([71, 73, 75, 77].contains(code))
      return "Snow";
    else if ([80, 81, 82].contains(code))
      return "Rain Showers";
    else if ([85, 86].contains(code))
      return "Snow Showers";
    else if ([95, 96, 99].contains(code))
      return "Thunderstorm";
    return "Unknown Weather";
  }

  String getMonth(String date) {
    int month = int.parse(date.split("-")[1]);
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Invalid Month";
    }
  }

  double? temperature_2m_max,
      temperature_2m_min,
      temperature_2m_mean,
      apparent_temperature_max,
      apparent_temperature_min,
      apparent_temperature_mean,
      wind_speed_10m_mean;
  int? weather_code, wind_direction_10m_dominant, precipitation_probability_max;

  String getDay(String date) {
    return int.parse(date.split("-")[2]).toString();
  }

  void changeScreen(DailyWeather weather) {
    temperature_2m_max = weather.temperature_2m_max;
    temperature_2m_min = weather.temperature_2m_min;
    temperature_2m_mean = weather.temperature_2m_mean;
    apparent_temperature_max = weather.apparent_temperature_max;
    apparent_temperature_min = weather.apparent_temperature_min;
    apparent_temperature_mean = weather.apparent_temperature_mean;
    wind_speed_10m_mean = weather.wind_speed_10m_mean;
    weather_code = weather.weather_code;
    wind_direction_10m_dominant = weather.wind_direction_10m_dominant;
    precipitation_probability_max = weather.precipitation_probability_max;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    if (widget.dailyWeathers != null && widget.dailyWeathers!.isNotEmpty) {
      changeScreen(widget.dailyWeathers![0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var weather = widget.dailyWeathers;
    if (widget.dailyWeathers != null) {
      weather = weather!;
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 25),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(weather.length, (index) {
                  return GestureDetector(
                    onTap: () => changeScreen(weather![index]),
                    child: topButtons(weather![index].time),
                  );
                }),
              ),
            ),
            mainScreen(),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey.shade100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column mainScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(getWeatherImagePath(weather_code!), width: 150),
            Text(
              "$apparent_temperature_mean°C",
              style: TextStyle(fontSize: 70),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.all(8),
          child: Text(getWeatherDescription(weather_code!), style: TextStyle(fontSize: 50))),

        Row(children: [
          SizedBox(width: 15),
          Text("Max Temperature" ,style: TextStyle(fontSize: 20),),
          SizedBox(width: 55,),
          Text("Min Temperature", style: TextStyle(fontSize: 20),)
        ],),

        Row(children: [
          SizedBox(width: 15,),
          Text("$temperature_2m_max °C", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(width: 145,),
          Text("$temperature_2m_min °C", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ],
        ),
        Divider(thickness: 2, color: Colors.black,indent: 15, endIndent: 15,),

        Row(children: [
          SizedBox(width: 15,),
          Text("Max Apparent\nTemperature", style: TextStyle(fontSize: 20),),
          SizedBox(width: 85,),
          Text("Min Apparent\nTemperature", style: TextStyle(fontSize: 20),)
        ],),

        Row(children: [
          SizedBox(width: 15,),
          Text("$apparent_temperature_max °C", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(width: 147,),
          Text("$apparent_temperature_min °C", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
        ],),
        Divider(thickness: 2, color: Colors.black, indent: 15, endIndent: 15,),

        Row(children: [
          SizedBox(width: 15,),
          Text("Apparent\nTemperature", style: TextStyle(fontSize: 20),),
          SizedBox(width: 100,),
          Text("Precipitation\nProbability", style: TextStyle(fontSize: 20),)
        ],),

        Row(children: [
          SizedBox(width: 15,),
          Text("$apparent_temperature_mean °C", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(width: 147,),
          Text("$precipitation_probability_max %", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ],),

        Divider(thickness: 2, color: Colors.black, indent: 15, endIndent: 15,),

        Row(children: [
          SizedBox(width: 15,),
          Text("Wind Speed", style: TextStyle(fontSize: 20),),
          SizedBox(width: 100,),
          Text("Wind Direction", style: TextStyle(fontSize: 20),)
        ],),

        Row(children: [
          SizedBox(width: 15,),
          Text("$wind_speed_10m_mean m/s", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(width: 130,),
          Transform.rotate(angle: (wind_direction_10m_dominant!*3.14/180)-(90*3.14/180), child: Image.asset("assets/images/arrow.png", width: 25,),)
        ],)


      ],
    );
  }

  Container topButtons(String time) {
    return Container(
      margin: EdgeInsets.all(1),
      width: 135,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(getMonth(time), style: TextStyle(fontSize: 25)),
          Text(getDay(time), style: TextStyle(fontSize: 25)),
        ],
      ),
    );
  }
}
