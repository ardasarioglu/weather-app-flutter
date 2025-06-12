import 'package:flutter/material.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/services/json_service.dart';

class Home extends StatefulWidget {
  final CurrentWeather? currentWeather;
  final Function(String) onSearch;
  final String? city;
  const Home({
    super.key,
    required this.onSearch,
    this.currentWeather,
    this.city,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();

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

  void writeToJson(Map<String, dynamic> data) async {
    final jsonService = JsonService();
    await jsonService.writeJson(data);
  }

  Future<String> readJson() async {
    final jsonService = JsonService();
    Map<String, dynamic> data = await jsonService.readJson();
    return data["city"];
  }

  @override
  Widget build(BuildContext context) {
    var weather = widget.currentWeather;

    if (weather != null) {
      writeToJson({"city": widget.city});
      
      
      return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/background.png",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 35),
                Row(children: [textField(), searchButton()]),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      widget.city!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      getWeatherImagePath(weather.weather_code),
                      width: 150,
                    ),
                    Text(
                      "${weather.apparent_temperature}°C",
                      style: TextStyle(fontSize: 70),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getWeatherDescription(weather.weather_code),
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Apparent Temperature",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 30),
                    Text("Wind Speed", style: TextStyle(fontSize: 20)),
                  ],
                ),

                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "${weather.apparent_temperature}°C",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 174),
                    Text(
                      "${weather.wind_speed_10m} m/s",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Divider(
                  thickness: 3,
                  color: Colors.black,
                  indent: 15,
                  endIndent: 15,
                ),

                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Precipitation Probability",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 18),
                    Text("Wind Direction", style: TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "${weather.precipitation} %",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 185),
                    Transform.rotate(
                      angle:
                          (weather.wind_direction_10m * 3.14 / 180) -
                          (90 * 3.14 / 180),
                      child: Image.asset("assets/images/arrow.png", width: 30),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 75),
          Row(children: [textField(), searchButton()]),
        ],
      ),
    );
  }

  GestureDetector searchButton() {
    return GestureDetector(
      onTap: () {
        String city = _controller.text;
        widget.onSearch(city);
      },
      child: Container(
        //padding: EdgeInsets.only(right: 30, left: 0),
        margin: EdgeInsets.only(right: 10, left: 3),
        width: 100,
        height: 57,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff017AFE),
        ),
        child: Center(child: Text("Search", style: TextStyle(fontSize: 25))),
      ),
    );
  }

  Expanded textField() {
    return Expanded(
      child: Container(
        //padding: EdgeInsets.only(right: 0, left: 10),
        margin: EdgeInsets.only(left: 10, right: 3),
        child: TextField(
          onSubmitted: (value) => widget.onSearch(value),
          controller: _controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xff017AFE),
            labelText: "Search City",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
