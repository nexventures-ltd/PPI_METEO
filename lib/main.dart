import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meteo_app/Screens/dashboard_screen.dart';

import 'theme/theme_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MeteoRwandaApp());
}

class MeteoRwandaApp extends StatefulWidget {
  @override
  _MeteoRwandaAppState createState() => _MeteoRwandaAppState();
}

class _MeteoRwandaAppState extends State<MeteoRwandaApp> {
  final ThemeProvider themeProvider = ThemeProvider();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeProvider,
      builder: (context, child) {
        return MaterialApp(
          title: 'MeteoRwanda',
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routes: {
            '/': (context) => DashboardScreen(themeProvider: themeProvider),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}