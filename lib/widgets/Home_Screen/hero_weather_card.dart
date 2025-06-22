import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math' as math;

class HeroWeatherCard extends StatelessWidget {
  final ThemeData theme;
  final String selectedLocation;
  final AnimationController pulseController;

  const HeroWeatherCard({
    Key? key,
    required this.theme,
    required this.selectedLocation,
    required this.pulseController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedLocation,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '26°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 56,
                        fontWeight: FontWeight.w200,
                        height: 1.0,
                      ),
                    ),
                    const Text(
                      'Partly Cloudy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AnimatedBuilder(
                  animation: pulseController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: pulseController.value * 2 * math.pi * 0.05,
                      child: const Icon(
                        Icons.wb_cloudy_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGlassDetail('Humidity', '65%', Icons.water_drop_outlined),
                Container(
                  width: 1,
                  height: 32,
                  color: Colors.white.withOpacity(0.2),
                ),
                _buildGlassDetail('Wind', '12 km/h', Icons.air),
                Container(
                  width: 1,
                  height: 32,
                  color: Colors.white.withOpacity(0.2),
                ),
                _buildGlassDetail('UV', '6', Icons.wb_sunny_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.9),
          size: 18,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}