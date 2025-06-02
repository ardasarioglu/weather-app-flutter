class HourlyWeather {
  String time;
  double wind_speed_10m,
      temperature_2m,
      apparent_temperature;

  int weather_code, precipitation_probability, wind_direction_10m;

  HourlyWeather(
    this.time,
    this.weather_code,
    this.wind_speed_10m,
    this.temperature_2m,
    this.apparent_temperature,
    this.precipitation_probability,
    this.wind_direction_10m,
  );
}
