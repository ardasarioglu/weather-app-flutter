class CurrentWeather {
  double temperature_2m, apparent_temperature, precipitation, wind_speed_10m;

  int weather_code, wind_direction_10m;

  CurrentWeather(
    this.temperature_2m,
    this.weather_code,
    this.apparent_temperature,
    this.precipitation,
    this.wind_speed_10m,
    this.wind_direction_10m,
  );
}
