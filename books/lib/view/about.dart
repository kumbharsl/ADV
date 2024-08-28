import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the current theme data
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        // Set AppBar color based on the current theme's brightness
        backgroundColor: theme.brightness == Brightness.dark
            ? Colors.black
            : const Color(0xFF8B4513),
        // Optionally, adjust the AppBar title color based on brightness
        iconTheme: IconThemeData(
          color:
              theme.brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'This is the About Us page. Here you can provide information about your app or organization.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // Add more content as needed
          ],
        ),
      ),
    );
  }
}
