class DailyWeather {
  String time;
  double temperature_2m_max,
      temperature_2m_min,
      temperature_2m_mean,
      apparent_temperature_max,
      apparent_temperature_min,
      apparent_temperature_mean,
      wind_speed_10m_mean;
  int weather_code, wind_direction_10m_dominant, precipitation_probability_max;

  DailyWeather(
    this.time,
    this.weather_code,
    this.temperature_2m_max,
    this.temperature_2m_min,
    this.temperature_2m_mean,
    this.apparent_temperature_max,
    this.apparent_temperature_min,
    this.apparent_temperature_mean,
    this.wind_direction_10m_dominant,
    this.wind_speed_10m_mean,
    this.precipitation_probability_max,
  );
}
