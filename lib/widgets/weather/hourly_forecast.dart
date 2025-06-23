import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final List<Map<String, dynamic>> hours;

  const HourlyForecast({
    Key? key,
    required this.hours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: hours.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final hour = hours[index];
          return Container(
            width: 60,
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? theme.colorScheme.surface.withOpacity(0.5)
                  : theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hour['time'],
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                Icon(
                  hour['icon'],
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                Text(
                  '${hour['temp']}°',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (hour['precip'] > 0)
                  Text(
                    '${hour['precip']}%',
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.primary,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}