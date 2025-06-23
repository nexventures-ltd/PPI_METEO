import 'package:flutter/material.dart';

class CurrentWeather extends StatelessWidget {
  final String location;
  final int temperature;
  final String condition;
  final int high;
  final int low;
  final int feelsLike;

  const CurrentWeather({
    Key? key,
    required this.location,
    required this.temperature,
    required this.condition,
    required this.high,
    required this.low,
    required this.feelsLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            '$temperature°',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w200,
              color: theme.colorScheme.onSurface,
              height: 1.0,
            ),
          ),
          Text(
            condition,
            style: TextStyle(
              fontSize: 20,
              color: theme.colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'H: $high°  L: $low°',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Feels like $feelsLike°',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}