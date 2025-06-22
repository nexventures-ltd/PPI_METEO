import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  
  const SplashScreen({
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _particleController;
  late AnimationController _waveController;
  late AnimationController _fadeController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _particleRotation;
  late Animation<double> _waveAnimation;
  late Animation<double> _fadeOut;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    // Particle animations
    _particleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    _particleRotation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );

    // Wave animation
    _waveController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _waveAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );

    // Fade out animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  void _startAnimationSequence() async {
    // Start logo animation
    await Future.delayed(const Duration(milliseconds: 500));
    _logoController.forward();

    // Start text animation
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    // Wait for animations to complete, then navigate
    await Future.delayed(const Duration(milliseconds: 3000));
    _fadeController.forward();

    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _particleController.dispose();
    _waveController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _fadeOut,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeOut.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          theme.colorScheme.background,
                          theme.colorScheme.surface,
                          theme.colorScheme.primary.withOpacity(0.7),
                          theme.colorScheme.secondary.withOpacity(0.5),
                        ]
                      : [
                          const Color(0xFF1E3A8A), // Deep blue
                          const Color(0xFF3B82F6), // Blue
                          const Color(0xFF06B6D4), // Cyan
                          const Color(0xFF8B5CF6), // Purple
                        ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Animated background waves
                  _buildAnimatedWaves(isDark),
                  
                  // Floating particles
                  _buildFloatingParticles(isDark),
                  
                  // Main content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo with animations
                        AnimatedBuilder(
                          animation: _logoController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _logoScale.value,
                              child: Opacity(
                                opacity: _logoOpacity.value,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? theme.colorScheme.onBackground.withOpacity(0.15)
                                        : Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDark
                                            ? theme.colorScheme.onBackground.withOpacity(0.2)
                                            : Colors.white.withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.cloud,
                                    size: 60,
                                    color: isDark
                                        ? theme.colorScheme.onBackground
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // App title with slide animation
                        SlideTransition(
                          position: _textSlide,
                          child: AnimatedBuilder(
                            animation: _textOpacity,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _textOpacity.value,
                                child: Column(
                                  children: [
                                    Text(
                                      'METEO RWANDA',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? theme.colorScheme.onBackground
                                            : Colors.white,
                                        letterSpacing: 2,
                                        shadows: isDark
                                            ? null
                                            : [
                                                const Shadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 2),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Real-Time Weather Data',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isDark
                                            ? theme.colorScheme.onBackground.withOpacity(0.8)
                                            : Colors.white70,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Dissemination System',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isDark
                                            ? theme.colorScheme.onBackground.withOpacity(0.8)
                                            : Colors.white70,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 50),
                        
                        // Loading indicator
                        AnimatedBuilder(
                          animation: _textController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _textOpacity.value,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        isDark
                                            ? theme.colorScheme.primary
                                            : Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Loading weather data...',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark
                                          ? theme.colorScheme.onBackground.withOpacity(0.6)
                                          : Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  // Bottom branding
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _textOpacity.value,
                          child: Column(
                            children: [
                              Text(
                                'Powered by Rwanda Meteorology Agency',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? theme.colorScheme.onBackground.withOpacity(0.5)
                                      : Colors.white54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Version 1.0.0',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark
                                      ? theme.colorScheme.onBackground.withOpacity(0.4)
                                      : Colors.white38,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedWaves(bool isDark) {
    return AnimatedBuilder(
      animation: _waveAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(_waveAnimation.value, isDark: isDark),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildFloatingParticles(bool isDark) {
    return AnimatedBuilder(
      animation: _particleRotation,
      builder: (context, child) {
        return Stack(
          children: List.generate(8, (index) {
            final angle = (_particleRotation.value + (index * 0.785)) % (2 * 3.14159);
            final radius = 100.0 + (index * 20);
            final x = (MediaQuery.of(context).size.width / 2) + 
                     (radius * 0.5 * (index % 2 == 0 ? 1 : -1)) * 
                     (0.5 + 0.5 * (index / 8)) * 
                     (0.8 + 0.2 * (angle / (2 * 3.14159)));
            final y = (MediaQuery.of(context).size.height / 2) + 
                     (radius * (index % 3 == 0 ? 1 : -1)) * 
                     (0.3 + 0.2 * (index / 8)) * 
                     (0.8 + 0.2 * (angle / (2 * 3.14159)));

            return Positioned(
              left: x,
              top: y,
              child: Transform.rotate(
                angle: angle,
                child: Container(
                  width: 4 + (index % 3) * 2,
                  height: 4 + (index % 3) * 2,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Theme.of(context).colorScheme.onBackground.withOpacity(0.2 - (index * 0.02))
                        : Colors.white.withOpacity(0.3 - (index * 0.03)),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Theme.of(context).colorScheme.onBackground.withOpacity(0.05)
                            : Colors.white.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final bool isDark;

  WavePainter(this.animationValue, {required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? Colors.white.withOpacity(0.05)
          : Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = 20.0;
    final waveLength = size.width / 2;

    // Create wave pattern
    path.moveTo(0, size.height * 0.8);
    
    for (double x = 0; x <= size.width; x += 1) {
      final y = size.height * 0.8 + 
                waveHeight * 
                (0.5 * (1 + (x / waveLength + animationValue * 2) % 1)) + 
                waveHeight * 0.3 * 
                (0.5 * (1 + (x / (waveLength * 0.7) + animationValue * 1.5) % 1));
      path.lineTo(x, y);
    }
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Second wave
    final paint2 = Paint()
      ..color = isDark
          ? Colors.white.withOpacity(0.02)
          : Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.9);
    
    for (double x = 0; x <= size.width; x += 1) {
      final y = size.height * 0.9 + 
                waveHeight * 0.5 * 
                (0.5 * (1 + (x / waveLength * 1.3 + animationValue * -1.8) % 1));
      path2.lineTo(x, y);
    }
    
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || 
           oldDelegate.isDark != isDark;
  }
}