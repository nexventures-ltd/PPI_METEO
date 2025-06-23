import 'package:flutter/material.dart';

class DailyForecast extends StatelessWidget {
  final List<Map<String, dynamic>> days;

  const DailyForecast({
    Key? key,
    required this.days,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '7-DAY FORECAST',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  letterSpacing: 1,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...days.map((day) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    day['day'],
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  child: Icon(
                    day['icon'],
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                if (day['pop'] > 0)
                  Expanded(
                    child: Text(
                      '${day['pop']}%',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                Expanded(
                  child: Text(
                    '${day['high']}°',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${day['low']}°',
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}