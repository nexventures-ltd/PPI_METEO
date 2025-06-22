import 'package:flutter/material.dart';

class ModernBottomNav extends StatelessWidget {
  final ThemeData theme;
  final bool isDark;
  final int currentIndex;
  final Function(int) onTabChanged;

  const ModernBottomNav({
    Key? key,
    required this.theme,
    required this.isDark,
    required this.currentIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabChanged,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.5),
          elevation: 0,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 22),
              activeIcon: Icon(Icons.home, size: 22),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined, size: 22),
              activeIcon: Icon(Icons.cloud, size: 22),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined, size: 22),
              activeIcon: Icon(Icons.map, size: 22),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined, size: 22),
              activeIcon: Icon(Icons.settings, size: 22),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}