import 'package:flutter/material.dart';

class WeatherDetails extends StatelessWidget {
  final int windSpeed;
  final int humidity;
  final int uvIndex;
  final int pressure;
  final int visibility;

  const WeatherDetails({
    Key? key,
    required this.windSpeed,
    required this.humidity,
    required this.uvIndex,
    required this.pressure,
    required this.visibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WEATHER DETAILS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3,
            children: [
              _buildDetailItem(context, 'Wind', '$windSpeed km/h', Icons.air),
              _buildDetailItem(context, 'Humidity', '$humidity%', Icons.water_drop),
              _buildDetailItem(context, 'UV Index', uvIndex.toString(), Icons.wb_sunny),
              _buildDetailItem(context, 'Pressure', '$pressure hPa', Icons.speed),
              _buildDetailItem(context, 'Visibility', '$visibility km', Icons.visibility),
              _buildDetailItem(context, 'Dew Point', '18°', Icons.water),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.surface.withOpacity(0.5)
            : theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}