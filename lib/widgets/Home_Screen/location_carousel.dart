import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocationCarousel extends StatelessWidget {
  final ThemeData theme;
  final bool isDark;
  final String selectedLocation;
  final List<Map<String, dynamic>> locations;
  final Function(String) onLocationChanged;

  const LocationCarousel({
    Key? key,
    required this.theme,
    required this.isDark,
    required this.selectedLocation,
    required this.locations,
    required this.onLocationChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          final isSelected = location['name'] == selectedLocation;
          
          return GestureDetector(
            onTap: () {
              onLocationChanged(location['name']);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isSelected 
                        ? theme.colorScheme.primary.withOpacity(0.3)
                        : theme.colorScheme.onSurface.withOpacity(0.1),
                    blurRadius: isSelected ? 12 : 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    location['name'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                          ? Colors.white 
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${location['temp']}°',
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected 
                          ? Colors.white.withOpacity(0.8)
                          : theme.colorScheme.onSurface.withOpacity(0.6),
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
}