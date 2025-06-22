import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meteo_app/widgets/Home_Screen/ai_insights.dart';
import 'package:meteo_app/widgets/Home_Screen/floating_weather_button.dart';
import 'package:meteo_app/widgets/Home_Screen/hero_weather_card.dart';
import 'package:meteo_app/widgets/Home_Screen/holographic_forecast.dart';
import 'package:meteo_app/widgets/Home_Screen/location_carousel.dart';
import 'package:meteo_app/widgets/Home_Screen/metrics_grid.dart';
import 'package:meteo_app/widgets/Home_Screen/modern_bottom_nav.dart';
import 'package:meteo_app/widgets/Home_Screen/modern_header.dart';
import 'package:meteo_app/widgets/Home_Screen/neural_alert.dart';
import 'dart:math' as math;
import '../theme/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  
  const DashboardScreen({Key? key, required this.themeProvider}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  String selectedLocation = 'Kigali';
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> locations = [
    {'name': 'Kigali', 'temp': 26, 'condition': 'Partly Cloudy'},
    {'name': 'Butare', 'temp': 24, 'condition': 'Sunny'},
    {'name': 'Gisenyi', 'temp': 28, 'condition': 'Cloudy'},
    {'name': 'Ruhengeri', 'temp': 22, 'condition': 'Rainy'},
    {'name': 'Byumba', 'temp': 25, 'condition': 'Clear'},
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0F172A),
                    const Color(0xFF1E293B),
                    const Color(0xFF334155),
                  ]
                : [
                    const Color(0xFFF8FAFC),
                    const Color(0xFFE2E8F0),
                    const Color(0xFFCBD5E1),
                  ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModernHeader(theme: theme, isDark: isDark, themeProvider: widget.themeProvider, pulseAnimation: _pulseAnimation),
                  const SizedBox(height: 24),
                  LocationCarousel(
                    theme: theme,
                    isDark: isDark,
                    selectedLocation: selectedLocation,
                    locations: locations,
                    onLocationChanged: (location) {
                      setState(() {
                        selectedLocation = location;
                      });
                      HapticFeedback.lightImpact();
                    },
                  ),
                  const SizedBox(height: 24),
                  HeroWeatherCard(
                    theme: theme,
                    selectedLocation: selectedLocation,
                    pulseController: _pulseController,
                  ),
                  const SizedBox(height: 20),
                  NeuralAlert(theme: theme, isDark: isDark),
                  const SizedBox(height: 24),
                  AIInsights(theme: theme, isDark: isDark),
                  const SizedBox(height: 24),
                  HolographicForecast(theme: theme, isDark: isDark),
                  const SizedBox(height: 24),
                  MetricsGrid(theme: theme, isDark: isDark),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ModernBottomNav(
        theme: theme,
        isDark: isDark,
        currentIndex: _currentIndex,
        onTabChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          HapticFeedback.lightImpact();
        },
      ),
      floatingActionButton: FloatingWeatherButton(
        theme: theme,
        pulseAnimation: _pulseAnimation,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}