import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final void Function() onToggleDarkMode; // Added this for completeness

  const SettingPage({
    super.key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              isDarkMode ? 'assets/black.png' : 'assets/old1.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main content
          Center(
            child: Text(
              'Setting Page content here\nLanguage: $selectedLanguage',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
