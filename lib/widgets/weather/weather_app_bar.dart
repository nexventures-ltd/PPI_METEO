import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meteo_app/theme/theme_provider.dart';

class WeatherAppBar extends StatelessWidget {
  final String location;
  final double scrollOffset;
  final ThemeProvider themeProvider;
  
  final VoidCallback? onBackPressed;


  const WeatherAppBar({
    Key? key,
    required this.location,
    required this.scrollOffset,
    required this.themeProvider,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final opacity = scrollOffset > 10 ? 1.0 : scrollOffset / 10;

    return SliverAppBar(
      expandedHeight: 100.0,
      stretch: true,
      pinned: true,
      floating: true,
      backgroundColor: isDark
          ? theme.colorScheme.surface.withOpacity(opacity)
          : theme.colorScheme.primary.withOpacity(opacity * 0.8),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: theme.colorScheme.onSurface),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            isDark ? Icons.light_mode : Icons.dark_mode,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () {
            themeProvider.toggleTheme();
            HapticFeedback.lightImpact();
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          location,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      theme.colorScheme.background,
                      theme.colorScheme.surface.withOpacity(0.1),
                    ]
                  : [
                      theme.colorScheme.primary.withOpacity(0.3),
                      theme.colorScheme.primary.withOpacity(0.1),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}