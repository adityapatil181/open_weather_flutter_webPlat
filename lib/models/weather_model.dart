class WeatherModel {
  final String city;
  final String country;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final String description;
  final String icon;
  final double windSpeed;
  final double? rainLastHour;
  final int cloudCoverage;

  WeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.description,
    required this.icon,
    required this.windSpeed,
    this.rainLastHour,
    required this.cloudCoverage,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      country: json['sys']['country'],
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      rainLastHour: json['rain'] != null ? (json['rain']['1h'] as num?)?.toDouble() : null,
      cloudCoverage: json['clouds']['all'],
    );
  }
}
