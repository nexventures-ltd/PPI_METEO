import 'package:flutter/material.dart';

class MetricsGrid extends StatelessWidget {
  final ThemeData theme;
  final bool isDark;

  const MetricsGrid({
    Key? key,
    required this.theme,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final metrics = [
      {'title': 'Temperature', 'value': '26°C', 'icon': Icons.thermostat, 'color': Colors.red},
      {'title': 'Rainfall', 'value': '12mm', 'icon': Icons.water_drop, 'color': Colors.blue},
      {'title': 'Pressure', 'value': '1013hPa', 'icon': Icons.speed, 'color': Colors.green},
      {'title': 'Visibility', 'value': '10km', 'icon': Icons.visibility, 'color': Colors.purple},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onSurface.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (metric['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  metric['icon'] as IconData,
                  color: metric['color'] as Color,
                  size: 20,
                ),
              ),
              const Spacer(),
              Text(
                metric['value'] as String,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                metric['title'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}