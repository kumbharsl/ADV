import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final bool isDarkMode;
  final String selectedLanguage;

  const CategoryPage({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
  }) : super(key: key);

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
              'Category Page content here\nLanguage: $selectedLanguage',
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
