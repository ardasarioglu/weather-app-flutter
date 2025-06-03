import 'package:flutter/material.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/daily_weather.dart';
import 'package:weather_app/models/hourly_weather.dart';
import 'package:weather_app/screens/daily.dart';
import 'package:weather_app/screens/home.dart';
import 'package:weather_app/screens/hourly.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _textController = TextEditingController();
  CurrentWeather? currentWeather;
  List<DailyWeather>? dailyWeathers;
  List<HourlyWeather>? hourlyWeathers;
  String? cityName;

  void func(String city) async {
    final data = await WeatherService().getLocation(city);
    setState(() {
      currentWeather = data["currentWeather"];
      dailyWeathers = data["dailyWeathers"];
      hourlyWeathers = data["hourlyWeathers"];
      cityName = data["city"];
    });
  }

  void func2() async {
    Map<String, dynamic>? myLocation = await LocationService().getLocation();

    if (myLocation != null) {
      final data = await WeatherService().getLocation2(
        myLocation["latitude"],
        myLocation["longitude"],
      );

      setState(() {
        currentWeather = data["currentWeather"];
        dailyWeathers = data["dailyWeathers"];
        hourlyWeathers = data["hourlyWeathers"];
        cityName = data["city"];
      });
    }
  }

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    func2();
  }

  int currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      Home(onSearch: func, currentWeather: currentWeather, city: cityName,),
      Hourly(hourlyWeathers: hourlyWeathers ?? []),
      Daily(dailyWeathers: dailyWeathers ?? []),
    ];

    if (currentWeather == null ||
        dailyWeathers == null ||
        hourlyWeathers == null) {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 3),
                    child: TextField(
                      onSubmitted: (value) {
                        func(value);
                      },
                      controller: _textController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.shade100,
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
                ),

                GestureDetector(
                  onTap: () {
                    String city = _textController.text;
                    if (city != "") {
                      func(city);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left: 3),
                    width: 100,
                    height: 57,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey.shade100,
                    ),
                    child: Center(
                      child: Text("Search", style: TextStyle(fontSize: 25)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return _mainScreen(pages);
  }

  Scaffold _mainScreen(List<StatefulWidget> pages) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff9BE9FE),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset(
              currentIndex == 0
                  ? "assets/images/home2.png"
                  : "assets/images/home1.png",
              width: 60,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset(
              currentIndex == 1
                  ? "assets/images/hourly2.png"
                  : "assets/images/hourly1.png",
              width: 60,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset(
              currentIndex == 2
                  ? "assets/images/daily2.png"
                  : "assets/images/daily1.png",
              width: 60,
            ),
          ),
        ],
      ),
    );
  }
}
