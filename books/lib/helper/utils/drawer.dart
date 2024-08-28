import 'package:books/view/about.dart';
import 'package:flutter/material.dart';

class DrewerScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function() onToggleDarkMode;
  final void Function(String) onLanguageSelected;

  const DrewerScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onLanguageSelected,
  });

  @override
  _DrewerScreenState createState() => _DrewerScreenState();
}

class _DrewerScreenState extends State<DrewerScreen> {
  String _selectedLanguage = 'English';

  void _onLanguageSelected(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    widget.onLanguageSelected(
        language); // Notify parent about the language change
  }

  void _navigateToAboutUs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/old.png', // Replace with your image path
            fit: BoxFit.cover,
          ),
          // Drawer content
          ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF8B4513),
                  //  Make the header background transparent
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Color(0xFF8B4513),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your app idea',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Amazing bootstrap',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Laurent Michenaud',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'lmichenaud@gmail.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  items: const [
                    DropdownMenuItem(
                      value: 'English',
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: 'Marathi',
                      child: Text('Marathi'),
                    ),
                    DropdownMenuItem(
                      value: 'Hindi',
                      child: Text('Hindi'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _onLanguageSelected(value);
                    }
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: widget.isDarkMode,
                  onChanged: (value) {
                    widget.onToggleDarkMode();
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About Us'),
                onTap: _navigateToAboutUs,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
