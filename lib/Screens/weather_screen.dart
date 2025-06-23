import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meteo_app/widgets/Home_Screen/modern_bottom_nav.dart';
import 'package:meteo_app/widgets/weather/current_weather.dart';
import 'package:meteo_app/widgets/weather/daily_forecast.dart';
import 'package:meteo_app/widgets/weather/hourly_forecast.dart';
import 'package:meteo_app/widgets/weather/weather_actions.dart';
import '../../theme/theme_provider.dart';
import 'package:meteo_app/widgets/weather/weather_details.dart';

/// Professional Weather Screen with modern design and responsive layout
/// Handles navigation, state management, and theme switching
class WeatherScreen extends StatefulWidget {
  final String location;
  final ThemeProvider themeProvider;
  final VoidCallback? onLocationChanged;

  const WeatherScreen({
    Key? key,
    required this.location,
    required this.themeProvider,
    this.onLocationChanged,
  }) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // Controllers and Animation
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late AnimationController _refreshController;
  late Animation<double> _fadeAnimation;

  // State Management
  double _scrollOffset = 0.0;
  bool _isLoading = true;
  bool _isRefreshing = false;
  String? _errorMessage;
  int _currentIndex = 1; // Set to weather tab (assuming it's index 1)

  // Weather Data - Mock data structure
  final Map<String, dynamic> _currentWeather = {
    'temperature': 26,
    'condition': 'Partly Cloudy',
    'high': 28,
    'low': 18,
    'feelsLike': 27,
    'windSpeed': 12,
    'humidity': 65,
    'uvIndex': 6,
    'pressure': 1013,
    'visibility': 10,
  };

  // Constants
  static const double _maxScrollOffset = 200.0;
  static const Duration _animationDuration = Duration(milliseconds: 300);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadWeatherData();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  void didUpdateWidget(WeatherScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      _loadWeatherData();
    }
  }

  /// Initialize all controllers and animations
  void _initializeControllers() {
    _scrollController = ScrollController()..addListener(_handleScrollChange);

    _fadeController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  /// Dispose all controllers
  void _disposeControllers() {
    _scrollController.dispose();
    _fadeController.dispose();
    _refreshController.dispose();
  }

  /// Handle scroll changes for parallax effects
  void _handleScrollChange() {
    if (!mounted) return;

    final offset = _scrollController.offset;
    setState(() {
      _scrollOffset = (offset / _maxScrollOffset).clamp(0.0, 1.0);
    });
  }

  /// Load weather data - simulated async operation
  Future<void> _loadWeatherData() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        _fadeController.forward();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load weather data. Please try again.';
          _isLoading = false;
        });
      }
    }
  }

  /// Handle pull-to-refresh
  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() => _isRefreshing = true);
    _refreshController.repeat();

    try {
      await _loadWeatherData();
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Minimum refresh time
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
        _refreshController.stop();
        _refreshController.reset();
      }
    }
  }

  /// Handle back navigation
  void _handleBackPressed() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  /// Build gradient background based on theme and weather
  BoxDecoration _buildBackgroundDecoration() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Dynamic colors based on weather condition and time
    List<Color> gradientColors = _getWeatherGradient(
      _currentWeather['condition'] as String,
      isDark,
      theme.colorScheme,
    );

    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
        stops: const [0.0, 0.6, 1.0],
      ),
    );
  }

  /// Get gradient colors based on weather condition
  List<Color> _getWeatherGradient(
    String condition,
    bool isDark,
    ColorScheme colorScheme,
  ) {
    final conditionLower = condition.toLowerCase();

    if (conditionLower.contains('sunny') || conditionLower.contains('clear')) {
      return isDark
          ? [
              Colors.indigo.shade900,
              Colors.purple.shade900,
              colorScheme.surface,
            ]
          : [
              Colors.blue.shade300,
              Colors.lightBlue.shade100,
              colorScheme.surface,
            ];
    } else if (conditionLower.contains('cloud')) {
      return isDark
          ? [
              Colors.blueGrey.shade800,
              Colors.blueGrey.shade900,
              colorScheme.surface,
            ]
          : [Colors.grey.shade300, Colors.grey.shade100, colorScheme.surface];
    } else if (conditionLower.contains('rain') ||
        conditionLower.contains('storm')) {
      return isDark
          ? [Colors.indigo.shade800, Colors.blue.shade900, colorScheme.surface]
          : [Colors.blue.shade400, Colors.cyan.shade200, colorScheme.surface];
    }

    // Default gradient
    return isDark
        ? [colorScheme.background, colorScheme.surface, colorScheme.surface]
        : [
            colorScheme.primary.withOpacity(0.1),
            colorScheme.surface,
            colorScheme.surface,
          ];
  }

  /// Build custom app bar with back button and location
  Widget _buildCustomAppBar() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Back button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _handleBackPressed,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.2)
                        : Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: isDark ? Colors.white : Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Location and title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weather',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isDark
                        ? Colors.white.withOpacity(0.7)
                        : Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.location,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Theme toggle button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                widget.themeProvider.toggleTheme();
                HapticFeedback.lightImpact();
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.2)
                        : Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: isDark ? Colors.white : Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build loading state
  Widget _buildLoadingState() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading weather data...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  /// Build error state
  Widget _buildErrorState() {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'An error occurred',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadWeatherData,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build weather content
  Widget _buildWeatherContent() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          // Custom App Bar
          SliverToBoxAdapter(child: _buildCustomAppBar()),

          // Main Content
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 100, // Space for bottom navigation
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Current Weather Card
                CurrentWeather(
                  location: widget.location,
                  temperature: _currentWeather['temperature'],
                  condition: _currentWeather['condition'],
                  high: _currentWeather['high'],
                  low: _currentWeather['low'],
                  feelsLike: _currentWeather['feelsLike'],
                ),

                const SizedBox(height: 24),

                // Hourly Forecast
                HourlyForecast(hours: _generateHourlyForecast()),

                const SizedBox(height: 24),

                // Daily Forecast
                DailyForecast(days: _generateDailyForecast()),

                const SizedBox(height: 24),

                // Weather Details Grid
                WeatherDetails(
                  windSpeed: _currentWeather['windSpeed'],
                  humidity: _currentWeather['humidity'],
                  uvIndex: _currentWeather['uvIndex'],
                  pressure: _currentWeather['pressure'],
                  visibility: _currentWeather['visibility'],
                ),

                const SizedBox(height: 24),

                // Weather Actions
                const WeatherActions(),

                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// Generate hourly forecast data
  List<Map<String, dynamic>> _generateHourlyForecast() {
    return [
      {'time': 'Now', 'temp': 26, 'icon': Icons.wb_sunny, 'precip': 0},
      {'time': '1 PM', 'temp': 27, 'icon': Icons.wb_sunny, 'precip': 0},
      {'time': '2 PM', 'temp': 28, 'icon': Icons.wb_cloudy, 'precip': 0},
      {'time': '3 PM', 'temp': 27, 'icon': Icons.wb_cloudy, 'precip': 30},
      {'time': '4 PM', 'temp': 25, 'icon': Icons.grain, 'precip': 60},
      {'time': '5 PM', 'temp': 24, 'icon': Icons.grain, 'precip': 80},
      {'time': '6 PM', 'temp': 23, 'icon': Icons.wb_cloudy, 'precip': 20},
      {'time': '7 PM', 'temp': 22, 'icon': Icons.nightlight_round, 'precip': 0},
      {'time': '8 PM', 'temp': 21, 'icon': Icons.nightlight_round, 'precip': 0},
      {'time': '9 PM', 'temp': 20, 'icon': Icons.nightlight_round, 'precip': 5},
    ];
  }

  /// Generate daily forecast data
  List<Map<String, dynamic>> _generateDailyForecast() {
    return [
      {
        'day': 'Today',
        'high': 28,
        'low': 18,
        'icon': Icons.wb_sunny,
        'pop': 30,
        'condition': 'Partly Cloudy',
      },
      {
        'day': 'Tue',
        'high': 27,
        'low': 17,
        'icon': Icons.wb_cloudy,
        'pop': 20,
        'condition': 'Cloudy',
      },
      {
        'day': 'Wed',
        'high': 26,
        'low': 16,
        'icon': Icons.grain,
        'pop': 70,
        'condition': 'Light Rain',
      },
      {
        'day': 'Thu',
        'high': 25,
        'low': 15,
        'icon': Icons.thunderstorm,
        'pop': 90,
        'condition': 'Thunderstorms',
      },
      {
        'day': 'Fri',
        'high': 24,
        'low': 14,
        'icon': Icons.wb_cloudy,
        'pop': 40,
        'condition': 'Overcast',
      },
      {
        'day': 'Sat',
        'high': 26,
        'low': 16,
        'icon': Icons.wb_sunny,
        'pop': 10,
        'condition': 'Sunny',
      },
      {
        'day': 'Sun',
        'high': 28,
        'low': 18,
        'icon': Icons.wb_sunny,
        'pop': 0,
        'condition': 'Clear',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // Handle back button press if needed
        // Navigate to home
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: _buildBackgroundDecoration(),
          child: SafeArea(
            bottom: false,
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surface,
              displacement: 80,
              child: _isLoading
                  ? _buildLoadingState()
                  : _errorMessage != null
                  ? _buildErrorState()
                  : _buildWeatherContent(),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ModernBottomNav(
            theme: theme,
            isDark: isDark,
            currentIndex: _currentIndex,
            onTabChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              HapticFeedback.lightImpact();

              // Example navigation logic:
              if (index == 0) {
                // Already on Home, do nothing or maybe scroll to top
                Navigator.of(context).pushNamed('/home');
              } else if (index == 1) {
                Navigator.of(context).pushNamed('/weather');
              } else if (index == 2) {
                Navigator.of(context).pushNamed('/maps');
              } else if (index == 3) {
                Navigator.of(context).pushNamed('/settings');
              }
              // Add other navigation logic as needed
            },
          ),
        ),
      ),
    );
  }
}
