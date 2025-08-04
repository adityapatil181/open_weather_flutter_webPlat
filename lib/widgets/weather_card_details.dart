import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // City & Country
            Text(
              "${weather.city}, ${weather.country}",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Weather Icon
            Image.network(
              "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
              height: 80,
              errorBuilder: (_, __, ___) => const Icon(Icons.cloud),
            ),

            const SizedBox(height: 4),

            // Description
            Text(
              weather.description ?? "",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
            ),

            const SizedBox(height: 16),

            // Temperature
            Text(
              "${weather.temperature}°C",
              style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            // Extra weather info
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: [
                _infoTile("Feels like", "${weather.feelsLike}°C"),
                _infoTile("Humidity", "${weather.humidity}%"),
                _infoTile("Wind", "${weather.windSpeed} m/s"),
                if (weather.rainLastHour != null)
                  _infoTile("Rain (1h)", "${weather.rainLastHour} mm"),
                _infoTile("Clouds", "${weather.cloudCoverage}%"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
