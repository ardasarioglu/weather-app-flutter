import 'package:dio/dio.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/daily_weather.dart';
import 'package:weather_app/models/hourly_weather.dart';

class WeatherService {
  Future<Map<String, dynamic>> getLocation2(double latitude, double longitude) async {

    CurrentWeather currentWeather;
    List<DailyWeather> dailyWeathers = [];
    List<HourlyWeather> hourlyWeathers = [];

    String url =
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=weather_code,temperature_2m_max,temperature_2m_min,temperature_2m_mean,apparent_temperature_max,apparent_temperature_min,apparent_temperature_mean,wind_direction_10m_dominant,wind_speed_10m_mean,precipitation_probability_max&hourly=weather_code,wind_speed_10m,temperature_2m,apparent_temperature,precipitation_probability,wind_direction_10m&current=temperature_2m,weather_code,apparent_temperature,precipitation,wind_speed_10m,wind_direction_10m&timezone=auto";

    var dio = Dio();

    var response = await dio.get(url);

    var data = response.data;
    var dataCurrent = data["current"];
    var dataHourly = data["hourly"];
    var dataDaily = data["daily"];

    currentWeather = CurrentWeather(
      dataCurrent["temperature_2m"],
      dataCurrent["weather_code"],
      dataCurrent["apparent_temperature"],
      dataCurrent["precipitation"],
      dataCurrent["wind_speed_10m"],
      dataCurrent["wind_direction_10m"],
    );

    for (int i = 0; i < 72; i++) {
      hourlyWeathers.add(
        HourlyWeather(
          dataHourly["time"][i],
          dataHourly["weather_code"][i],
          dataHourly["wind_speed_10m"][i],
          dataHourly["temperature_2m"][i],
          dataHourly["apparent_temperature"][i],
          dataHourly["precipitation_probability"][i],
          dataHourly["wind_direction_10m"][i],
        ),
      );
    }

    for (int i = 0; i < 7; i++) {
      dailyWeathers.add(
        DailyWeather(
          dataDaily["time"][i],
          dataDaily["weather_code"][i],
          dataDaily["temperature_2m_max"][i],
          dataDaily["temperature_2m_min"][i],
          dataDaily["temperature_2m_mean"][i],
          dataDaily["apparent_temperature_max"][i],
          dataDaily["apparent_temperature_min"][i],
          dataDaily["apparent_temperature_mean"][i],
          dataDaily["wind_direction_10m_dominant"][i],
          dataDaily["wind_speed_10m_mean"][i],
          dataDaily["precipitation_probability_max"][i],
        ),
      );
    }
    return {
      "currentWeather": currentWeather,
      "dailyWeathers": dailyWeathers,
      "hourlyWeathers": hourlyWeathers,
    };

  }

  Future<Map<String, dynamic>> getLocation(String city) async {
    CurrentWeather currentWeather;
    List<DailyWeather> dailyWeathers = [];
    List<HourlyWeather> hourlyWeathers = [];

    String url =
        "https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1&language=tr&format=json";
    double latitude, longitude;
    var dio = Dio();

    var response = await dio.get(url);
    latitude = response.data["results"][0]["latitude"];
    longitude = response.data["results"][0]["longitude"];

    url =
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=weather_code,temperature_2m_max,temperature_2m_min,temperature_2m_mean,apparent_temperature_max,apparent_temperature_min,apparent_temperature_mean,wind_direction_10m_dominant,wind_speed_10m_mean,precipitation_probability_max&hourly=weather_code,wind_speed_10m,temperature_2m,apparent_temperature,precipitation_probability,wind_direction_10m&current=temperature_2m,weather_code,apparent_temperature,precipitation,wind_speed_10m,wind_direction_10m&timezone=auto";

    response = await dio.get(url);

    var data = response.data;
    var dataCurrent = data["current"];
    var dataHourly = data["hourly"];
    var dataDaily = data["daily"];

    currentWeather = CurrentWeather(
      dataCurrent["temperature_2m"],
      dataCurrent["weather_code"],
      dataCurrent["apparent_temperature"],
      dataCurrent["precipitation"],
      dataCurrent["wind_speed_10m"],
      dataCurrent["wind_direction_10m"],
    );

    for (int i = 0; i < 72; i++) {
      hourlyWeathers.add(
        HourlyWeather(
          dataHourly["time"][i],
          dataHourly["weather_code"][i],
          dataHourly["wind_speed_10m"][i],
          dataHourly["temperature_2m"][i],
          dataHourly["apparent_temperature"][i],
          dataHourly["precipitation_probability"][i],
          dataHourly["wind_direction_10m"][i],
        ),
      );
    }

    for (int i = 0; i < 7; i++) {
      dailyWeathers.add(
        DailyWeather(
          dataDaily["time"][i],
          dataDaily["weather_code"][i],
          dataDaily["temperature_2m_max"][i],
          dataDaily["temperature_2m_min"][i],
          dataDaily["temperature_2m_mean"][i],
          dataDaily["apparent_temperature_max"][i],
          dataDaily["apparent_temperature_min"][i],
          dataDaily["apparent_temperature_mean"][i],
          dataDaily["wind_direction_10m_dominant"][i],
          dataDaily["wind_speed_10m_mean"][i],
          dataDaily["precipitation_probability_max"][i],
        ),
      );
    }
    return {
      "currentWeather": currentWeather,
      "dailyWeathers": dailyWeathers,
      "hourlyWeathers": hourlyWeathers,
    };
  }
}
