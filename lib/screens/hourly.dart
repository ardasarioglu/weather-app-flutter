import 'package:flutter/material.dart';
import 'package:weather_app/models/hourly_weather.dart';

class Hourly extends StatefulWidget {
  final List<HourlyWeather>? hourlyWeathers;
  const Hourly({super.key, this.hourlyWeathers});

  @override
  State<Hourly> createState() => _HourlyState();
}

class _HourlyState extends State<Hourly> {
  String? day1,
      day2,
      day3,
      month1,
      month2,
      month3,
      date1str,
      date2str,
      date3str;

  List<HourlyWeather>? list1, list2, list3;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.hourlyWeathers != null) {
      list1 = widget.hourlyWeathers!.sublist(0, 24);
      list2 = widget.hourlyWeathers!.sublist(24, 48);
      list3 = widget.hourlyWeathers!.sublist(48, 72);

      date1str = widget.hourlyWeathers![0].time;
      date2str = widget.hourlyWeathers![24].time;
      date3str = widget.hourlyWeathers![48].time;

      DateTime date1 = DateTime.parse(date1str!);
      DateTime date2 = DateTime.parse(date2str!);
      DateTime date3 = DateTime.parse(date3str!);

      day1 = date1.day.toString();
      day2 = date2.day.toString();
      day3 = date3.day.toString();

      month1 = date1.month.toString();
      month2 = date2.month.toString();
      month3 = date3.month.toString();

      if (month1 == "1") {
        month1 = "January";
      } else if (month1 == "2") {
        month1 = "February";
      } else if (month1 == "3") {
        month1 = "March";
      } else if (month1 == "4") {
        month1 = "April";
      } else if (month1 == "5") {
        month1 = "May";
      } else if (month1 == "6") {
        month1 = "June";
      } else if (month1 == "7") {
        month1 = "July";
      } else if (month1 == "8") {
        month1 = "August";
      } else if (month1 == "9") {
        month1 = "September";
      } else if (month1 == "10") {
        month1 = "October";
      } else if (month1 == "11") {
        month1 = "November";
      } else if (month1 == "12") {
        month1 = "December";
      }

      if (month2 == "1") {
        month2 = "January";
      } else if (month2 == "2") {
        month2 = "February";
      } else if (month2 == "3") {
        month2 = "March";
      } else if (month2 == "4") {
        month2 = "April";
      } else if (month2 == "5") {
        month2 = "May";
      } else if (month2 == "6") {
        month2 = "June";
      } else if (month2 == "7") {
        month2 = "July";
      } else if (month2 == "8") {
        month2 = "August";
      } else if (month2 == "9") {
        month2 = "September";
      } else if (month2 == "10") {
        month2 = "October";
      } else if (month2 == "11") {
        month2 = "November";
      } else if (month2 == "12") {
        month2 = "December";
      }

      if (month3 == "1") {
        month3 = "January";
      } else if (month3 == "2") {
        month3 = "February";
      } else if (month3 == "3") {
        month3 = "March";
      } else if (month3 == "4") {
        month3 = "April";
      } else if (month3 == "5") {
        month3 = "May";
      } else if (month3 == "6") {
        month3 = "June";
      } else if (month3 == "7") {
        month3 = "July";
      } else if (month3 == "8") {
        month3 = "August";
      } else if (month3 == "9") {
        month3 = "September";
      } else if (month3 == "10") {
        month3 = "October";
      } else if (month3 == "11") {
        month3 = "November";
      } else if (month3 == "12") {
        month3 = "December";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hourlyWeathers != null) {
      if (widget.hourlyWeathers != null) {
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  "$month1 $day1",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 3, color: Colors.black),
                Column(
                  children: List.generate(list1!.length, (index) {
                    return Column(
                      children: [
                        ExpansionTile(
                          shape: Border(),
                          title: Text("$index:00"),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      getWeatherImagePath(
                                        widget
                                            .hourlyWeathers![index]
                                            .weather_code,
                                      ),
                                      width: 100,
                                    ),
                                    Text(
                                      getWeatherDescription(
                                        widget
                                            .hourlyWeathers![index]
                                            .weather_code,
                                      ),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.hourlyWeathers![index].temperature_2m} °C",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Text(
                                      "Apparent Temperature: ${widget.hourlyWeathers![index].apparent_temperature} °C",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Wind Speed: ${widget.hourlyWeathers![index].wind_speed_10m} m/s",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Precipitation Probability: ${widget.hourlyWeathers![index].precipitation_probability} %",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Wind Direction: ",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Transform.rotate(
                                          angle:
                                              (widget
                                                      .hourlyWeathers![index]
                                                      .wind_direction_10m *
                                                  3.14 /
                                                  180) -
                                              (90 * 3.14 / 180),
                                          child: Image.asset(
                                            "assets/images/arrow.png",
                                            width: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                      ],
                    );
                  }),
                ),
                Text(
                  "$month2 $day2",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Divider(thickness: 3, color: Colors.black,),
                Column(
                  children: List.generate(list2!.length, (index) {
                    index += 24;
                    return Column(
                      children: [
                        ExpansionTile(
                          shape: Border(),
                          title: Text("${index-24}:00"),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      getWeatherImagePath(
                                        widget
                                            .hourlyWeathers![index]
                                            .weather_code,
                                      ),
                                      width: 100,
                                    ),
                                    Text(
                                      getWeatherDescription(
                                        widget
                                            .hourlyWeathers![index]
                                            .weather_code,
                                      ),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.hourlyWeathers![index].temperature_2m} °C",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Text(
                                      "Apparent Temperature: ${widget.hourlyWeathers![index].apparent_temperature} °C",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Wind Speed: ${widget.hourlyWeathers![index].wind_speed_10m} m/s",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Precipitation Probability: ${widget.hourlyWeathers![index].precipitation_probability} %",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Wind Direction: ",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Transform.rotate(
                                          angle:
                                              (widget
                                                      .hourlyWeathers![index]
                                                      .wind_direction_10m *
                                                  3.14 /
                                                  180) -
                                              (90 * 3.14 / 180),
                                          child: Image.asset(
                                            "assets/images/arrow.png",
                                            width: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                      ],
                    );
                  }),
                ),
                Text("$month3 $day3", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Divider(thickness: 3, color: Colors.black,),
                Column(
                  children: List.generate(list2!.length, (index) {
                    index += 48;
                    return Column(
                      children: [
                        ExpansionTile(
                          shape: Border(),
                          title: Text("${index-48}:00"),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      getWeatherImagePath(
                                        widget
                                            .hourlyWeathers![index]
                                            .weather_code,
                                      ),
                                      width: 100,
                                    ),
                                    Text(
                                      getWeatherDescription(
                                        widget
                                            .hourlyWeathers![index]
                                            .weather_code,
                                      ),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.hourlyWeathers![index].temperature_2m} °C",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Text(
                                      "Apparent Temperature: ${widget.hourlyWeathers![index].apparent_temperature} °C",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Wind Speed: ${widget.hourlyWeathers![index].wind_speed_10m} m/s",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Precipitation Probability: ${widget.hourlyWeathers![index].precipitation_probability} %",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Wind Direction: ",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Transform.rotate(
                                          angle:
                                              (widget
                                                      .hourlyWeathers![index]
                                                      .wind_direction_10m *
                                                  3.14 /
                                                  180) -
                                              (90 * 3.14 / 180),
                                          child: Image.asset(
                                            "assets/images/arrow.png",
                                            width: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }
    }
    return Scaffold(body: Text("hourly", style: TextStyle(fontSize: 30)));
  }
}
